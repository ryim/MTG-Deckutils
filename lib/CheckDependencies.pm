#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for checking if a list of dependencies are present.
#   v1.4
#   ==========================================================

sub checkdependencies {
    my ($rootpath) = @_;

    ###########################################################################
    #   List of file paths - Files to check for before running a script       #
    my @files = (
        "bin/deckutils.pl",
        "lib/CurrentTime.pm",
        "doc/commandlist.txt",
        "lib/CmdCheck.pm",
        "lib/ToGet.pm",
        "lib/ListPrint.pm",
        "lib/DeckReader.pm",
        "lib/DeckDiff.pm",
        "lib/DeckMaths.pm",
        "lib/CheckDependencies.pm"
    );
    #                                                                         #
    ###########################################################################

    my $missingdependencies = 0;
    foreach my $file (@files) {                 # For each dependency
        $file = $rootpath . $file;
        unless (-e $file) {                     # Check if it exists
            print "Fatal error: Missing dependency:\n$file\n";
            $missingdependencies = 1;
        }
    }
    exit(1) if $missingdependencies == 1;       # Crap out if missing files
}

1

    #   Depreciation corner
