use strict;
use warnings;
use Test::More;
use File::Spec;

my $script = './string.pl';

sub run {
    my ($args, $input) = @_;
    my $cmd = "perl $script $args";
    open my $fh, "|-", $cmd or die $!;
    print $fh $input if defined $input;
    close $fh;
    # For output, use backticks:
    return `$cmd $args`;
}

# Uppercase
is(`perl $script upper foo bar`, "FOO\nBAR\n", 'upper works');

# Lowercase
is(`perl $script lower FOO BAR`, "foo\nbar\n", 'lower works');

# Trim
is(`perl $script trim "  foo " "bar  "`, "foo\nbar\n", 'trim works');

# Length
is(`perl $script length foo bar`, "3\n3\n", 'length works');

# Split
is(`perl $script split , "a,b,c"`, "a\nb\nc\n", 'split works');

# Join
is(`perl $script join , a b c`, "a,b,c\n", 'join works');

# Split0 (NUL-separated)
my $nul_input = "a\0b\0c\0";
is(`echo -ne "$nul_input" | perl $script split0`, "a\nb\nc\n", 'split0 works');

# Join0 (NUL-separated)
is(`perl $script join0 a b c`, "a\0b\0c\0", 'join0 works');

done_testing;
