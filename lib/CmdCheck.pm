#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for checking if a command has its required options
#   ==========================================================

sub checkvalidcmd {
    my ($cmdrootdir, $cmd, %opts) = @_;

    ###########################################################################
    #   Master hash of commands and required options                          #
    my %mastercmdlist = (
        "toget" => [
            "lib",
            "in"
        ],
        "deckdiff" => [
            "d1",
            "d2"
        ]
    );
    #                                                                         #
    ###########################################################################

    #   Check command is in the list
    if (! $mastercmdlist{$ARGV[0]}) {
        print "Error: Unknown command. Acceptable command values:\n\n";
        system("cat $cmdrootdir/doc/commandlist.txt");
        exit(1);
    }

    #   Check command has the required options
    my $missingoptions = 0;
    foreach my $neededopt (@{$mastercmdlist{$cmd}}) {
        if (! $opts{$neededopt}) {
            print "Error: missing required option: --$neededopt\n";
            $missingoptions = 1;
        }
    }
    if ($missingoptions == 1) {       # Die if missing required options
        print "\n";
        system("cat $cmdrootdir/doc/commandlist.txt");
        exit(2);
    }
}

1
