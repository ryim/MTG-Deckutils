#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for printing the current time in a nice format
#   v1.0
#   ==========================================================

sub timenow {
    my @time = localtime();
    my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    my $year = $time[5] + 1900;
    my $timenow = sprintf("%02d $months[$time[4]] $year %02d:%02d:%02d",
        $time[3], $time[2], $time[1], $time[0]);
    return($timenow);
}
1;
