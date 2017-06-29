#!/usr/bin/perl
use warnings;
use strict;

#   ===========================================================================
#   Module for working out the difference between 2 decks' main zones
#   v1.1
#   ===========================================================================

sub deckdiff {
    my ($rootdir, %opts) = @_;

    #   Load up each input deck
    my ($D1Iref, $D1ref, $D1SBref) = codtohashes($opts{"d1"});
    my ($D2Iref, $D2ref, $D2SBref) = codtohashes($opts{"d2"});

    #   If flag to include sideboard found, combine sideboards with maindecks
    if ($opts{"sideboard"}) {
        $D1ref = deckcombine($D1ref, $D1SBref);
        $D2ref = deckcombine($D2ref, $D2SBref);
    }

    #   Work out which cards are in both decks
    my $intref = deckintersect($D1ref, $D2ref);
    my %intersect = %{$intref};

    #   Work out cards that are unique to each deck
    my $d1uniqref = decksubtract($D1ref, $D2ref);
    my %d1uniq = %{$d1uniqref};
    my $d2uniqref = decksubtract($D2ref, $D1ref);
    my %d2uniq = %{$d2uniqref};

    #   Print out cards to get from input deck if there are any.
    print "\nCards in both decks\n" . "=" x 50 . "\n";
    if (%intersect) {
        listprint(%intersect);
    } else {
        print "None.\n";
    }
    print "\nCards in $opts{'d1'}\n" . "=" x 50 . "\n";
    if (%d1uniq) {
        listprint(%d1uniq);
    } else {
        print "None.\n";
    }
    print "\nCards in $opts{'d2'}\n" . "=" x 50 . "\n";
    if (%d2uniq) {
        listprint(%d2uniq);
    } else {
        print "None.\n";
    }

}

1
