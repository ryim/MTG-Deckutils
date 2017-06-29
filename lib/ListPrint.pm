#!/usr/bin/perl
use warnings;
use strict;

#   ===========================================================================
#   Module for printing hashes out nicely
#   v1.0
#   ===========================================================================

sub listprint {
    my (%list) = @_;

    #   Find the longest key and val and store their lengths
    my $keylen = 0;
    my $vallen = 0;
    foreach my $key (keys(%list)) {
        if (length($key) > $keylen) {
            $keylen = length($key);
        }
        if (length($list{$key}) > $vallen) {
            $vallen = length($list{$key});
        }
    }

    #   Add the two plus 1
    my $linelen = $vallen + $keylen + 1;

    #   Print each card and length out in alphabetical order
    my @keys = sort(keys(%list));              # MAke alphabetical list
    foreach my $key (@keys) {
        my $spaces = $linelen - length($key) - length($list{$key}); # to pad
        print $key . " " x $spaces . $list{$key} . "\n";
    }
}

1
