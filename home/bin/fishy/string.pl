#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
use open qw(:std :encoding(UTF-8));
use utf8;

# ---------- CLI parse ----------
@ARGV or exit 2;
my $mode = shift @ARGV;
my %modes = map { $_ => 1 } qw(upper lower trim length join join0 split split0);
$modes{$mode} or do { print STDERR "Unknown subcommand '$mode'. Use upper|lower|trim|length|join|join0|split|split0.\n"; exit 2 };

my $quiet = 0;
GetOptions('q|quiet' => \$quiet) or exit 2;

# ---------- IO helpers ----------
sub read_stdin_lines {
    my @lines;
    return @lines if -t *STDIN;
    while (defined(my $line = <STDIN>)) {
        chomp $line;
        push @lines, $line;
    }
    return @lines;
}

sub read_stdin_nul_records {
    return () if -t *STDIN;
    binmode(STDIN, ':raw');
    local $/;  # slurp
    my $data = <STDIN>;
    return () unless defined $data;
    # preserve trailing empties for now; we'll drop the final terminator later
    my @recs = split(/\0/, $data, -1);
    return @recs;
}

# Collect inputs (args first, then stdin) depending on mode family
my @inputs;
push @inputs, @ARGV if @ARGV;
if ($mode eq 'split0' or $mode eq 'join0') {
    push @inputs, read_stdin_nul_records();
} else {
    push @inputs, read_stdin_lines();
}

# ---------- shared ops ----------
sub do_case {
    my ($which, $in) = @_;
    my @out;
    my $changed = 0;
    for my $s (@$in) {
        my $o = $which eq 'upper' ? uc($s) : lc($s);
        $changed ||= ($o ne $s);
        push @out, $o;
    }
    return (\@out, $changed);
}

sub do_trim {
    my ($in) = @_;
    my @out;
    my $changed = 0;
    for my $s (@$in) {
        my $o = $s;
        $o =~ s/^\s+//u;
        $o =~ s/\s+$//u;
        $changed ||= ($o ne $s);
        push @out, $o;
    }
    return (\@out, $changed);
}

sub do_length {
    my ($in) = @_;
    my @out = map { length($_) } @$in;   # character count with UTF-8
    my $any_nonempty = scalar grep { length($_) > 0 } @$in;
    return (\@out, $any_nonempty);
}

# One function for split & split0
# is_nul => 0 for 'split' (requires a separator arg), 1 for 'split0' (sep = NUL)
sub do_split_like {
    my ($is_nul, $inputs_ref) = @_;
    my @inputs = @$inputs_ref;   # already merged: ARGV first, then stdin
    my @out;

    # Determine separator
    my $sep = $is_nul ? "\0" : do {
        @inputs or return (\@out, 0);    # need separator for 'split'
        shift @inputs;                   # first item is the SEP (from ARGV)
    };

    if ($is_nul) {
        # NUL-mode: inputs are already NUL records (we preserved trailing empties).
        @out = @inputs;

        # Drop exactly one trailing empty token if present (represents the terminal NUL),
        # but keep interior empties (e.g., "a\0\0b\0" => ["a", "", "b"]).
        pop @out if @out && $out[-1] eq '';
    } else {
        # Text-mode: split each remaining input on the separator; preserve empty fields.
        return (\@out, 0) unless @inputs;   # no strings to split
        for my $s (@inputs) {
            my @tok = length($sep) ? split(/\Q$sep\E/, $s, -1)
                                    : split(//, $s, -1);  # empty SEP => into chars
            push @out, @tok;
        }
    }

    my $had_output = scalar @out;
    return (\@out, $had_output);
}

# One function for join & join0
# is_nul => 0 for join (requires sep arg), 1 for join0 (sep = NUL; add trailing NUL)
sub do_join_like {
    my ($is_nul, $inputs_ref) = @_;
    my @inputs = @$inputs_ref;
    my @out;
    my $had_output = 0;

    # Determine the separator
    my $sep = $is_nul ? "\0" : do {
        @inputs or return (\@out, 0);   # need a separator for 'join'
        shift @inputs;                  # first element is SEP
    };

    # No strings to join → no output
    return (\@out, 0) unless @inputs;

    my $joined = join($sep, @inputs);
    $joined .= "\0" if $is_nul;         # only join0 gets a trailing NUL
    push @out, $joined;
    $had_output = 1;

    return (\@out, $had_output);
}

# Helper for input presence and usage errors
sub require_inputs {
    my ($count, $usage) = @_;
    if (@inputs < $count) {
        print STDERR "Usage: $0 $usage\n";
        exit 2;
    }
}

# ---------- dispatch ----------
my (@outputs, $changed, $had_output);

if ($mode eq 'upper' or $mode eq 'lower') {
    require_inputs(1, "$mode [STRING...]");
    my ($outref, $chg) = do_case($mode, \@inputs);
    @outputs = @$outref;
    $changed = $chg;
}
elsif ($mode eq 'trim') {
    require_inputs(1, "trim [STRING...]");
    my ($outref, $chg) = do_trim(\@inputs);
    @outputs = @$outref;
    $changed = $chg;
}
elsif ($mode eq 'length') {
    require_inputs(1, "length [STRING...]");
    my ($outref, $any_nonempty) = do_length(\@inputs);
    @outputs = @$outref;
    $had_output = $any_nonempty ? 0+@outputs : 0;
}
elsif ($mode eq 'split') {
    require_inputs(2, "split SEP [STRING...]");
    my ($outref, $had) = do_split_like(0, \@inputs);
    @outputs = @$outref;
    $had_output = $had;
}
elsif ($mode eq 'split0') {
    my ($outref, $had) = do_split_like(1, \@inputs);
    @outputs = @$outref;
    $had_output = $had;
}
elsif ($mode eq 'join') {
    require_inputs(2, "join SEP [STRING...]");
    my ($outref, $had) = do_join_like(0, \@inputs);
    @outputs = @$outref;
    $had_output = $had;
}
elsif ($mode eq 'join0') {
    my ($outref, $had) = do_join_like(1, \@inputs);
    @outputs = @$outref;
    $had_output = $had;
}

# ---------- output ----------
unless ($quiet) {
    if ($mode eq 'join0') {
        print $outputs[0] if @outputs;   # already has trailing NUL
    } else {
        print "$_\n" for @outputs;       # split0 prints lines (not NULs)
    }
}

# ---------- exit codes ----------
if ($mode eq 'upper' or $mode eq 'lower' or $mode eq 'trim') {
    exit($changed ? 0 : 1);
} elsif ($mode eq 'length') {
    # 0 if any NON-empty STRING was given, else 1
    my $any_nonempty = scalar grep { length($_) > 0 } @inputs;
    exit($any_nonempty ? 0 : 1);
} else {
    exit($had_output ? 0 : 1);
}
