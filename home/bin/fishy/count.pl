#!/usr/bin/env perl
use strict;
use warnings;

my $total = @ARGV;
$total++ while !-t *STDIN && <STDIN>;

print "$total\n";
exit !$total;

# use strict;
# use warnings;

# my $stdin_count = 0;

# # Only read stdin if it's not a terminal (i.e., something is piped/redirected)
# unless (-t *STDIN) {
#     while (<STDIN>) {
#         $stdin_count++;
#     }
# }

# my $arg_count = scalar @ARGV;
# my $total = $arg_count + $stdin_count;

# print "$total\n";
# exit($total > 0 ? 0 : 1);
