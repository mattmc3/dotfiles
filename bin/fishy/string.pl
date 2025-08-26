#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
use open qw(:std :encoding(UTF-8));   # read/write UTF-8
use utf8;

# --- Parse subcommand ---
@ARGV or exit 2;
my $mode = shift @ARGV;
($mode eq 'upper' or $mode eq 'lower' or $mode eq 'trim' or $mode eq 'length')
  or do { print STDERR "Unknown subcommand '$mode'. Use upper|lower|trim|length.\n"; exit 2 };

# --- Options ---
my $quiet = 0;
GetOptions('q|quiet' => \$quiet) or exit 2;

# --- Collect inputs: ARGV first, then piped stdin (if any) ---
my @inputs;
push @inputs, @ARGV if @ARGV;

if (!-t *STDIN) {
    while (defined(my $line = <STDIN>)) {
        chomp $line;
        push @inputs, $line;
    }
}

# No input → quiet exit 1 (fish-y behavior)
@inputs or exit 1;

# --- Process ---
my $changed = 0;
my @outputs;

if ($mode eq 'upper') {
    for my $s (@inputs) {
        my $o = uc($s);
        $changed ||= ($o ne $s);
        push @outputs, $o;
    }
}
elsif ($mode eq 'lower') {
    for my $s (@inputs) {
        my $o = lc($s);
        $changed ||= ($o ne $s);
        push @outputs, $o;
    }
}
elsif ($mode eq 'trim') {
    for my $s (@inputs) {
        my $o = $s;
        $o =~ s/^\s+//u;
        $o =~ s/\s+$//u;
        $changed ||= ($o ne $s);
        push @outputs, $o;
    }
}
elsif ($mode eq 'length') {
    # For 'length', exit code is 0 if there was any input at all
    for my $s (@inputs) {
        # length() counts characters with UTF-8 enabled
        push @outputs, length($s);
    }
}

# --- Output ---
unless ($quiet) {
    print "$_\n" for @outputs;
}

# --- Exit status ---
if ($mode eq 'length') {
    exit 0;                 # had input → 0
} else {
    exit($changed ? 0 : 1); # changed? → 0, else 1
}
