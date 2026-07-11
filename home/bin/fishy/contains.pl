#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long qw(:config no_auto_abbrev bundling require_order);

my $show_index = 0;
my $help       = 0;

GetOptions(
    'i|index' => \$show_index,
    'h|help'  => \$help,
) or do {
    print STDERR "Try --help for usage.\n";
    exit 2;
};

if ($help) {
    print <<'USAGE';
contains.pl - test if a word is present in a list (Fish-compatible)

Usage:
  contains.pl [OPTIONS] KEY [VALUES...]
  contains.pl [OPTIONS] -- KEY [VALUES...]

Options:
  -i, --index   Print the 1-based index of the first matching element.
  -h, --help    Show this help text.

Behavior:
  - Exits with status 0 if KEY is present in VALUES, otherwise 1.
  - With --index and a match, prints the index and exits 0.
  - Arguments beginning with '-' are treated as options until a lone '--'.
  - Exact string match (no globbing/regex).

Examples:
  contains.pl cat dog cat mouse        # exit 0
  contains.pl -i cat dog cat mouse     # prints "2", exit 0
  contains.pl -- -n -- -n -x           # search for literal "-n" among "-n" "-x"
USAGE
    exit 0;
}

# Need at least KEY
@ARGV or do {
    print STDERR "contains.pl: missing KEY\n";
    print STDERR "Try --help for usage.\n";
    exit 2;
};

my $key = shift @ARGV;
# No VALUES means "not contained"
if (!@ARGV) {
    exit 1;
}

my $idx = 0;
for my $i (0 .. $#ARGV) {
    if ($ARGV[$i] eq $key) {
        $idx = $i + 1;    # 1-based index per Fish
        last;
    }
}

if ($idx) {
    print "$idx\n" if $show_index;
    exit 0;
} else {
    # No output on miss, just nonzero status (like Fish)
    exit 1;
}
