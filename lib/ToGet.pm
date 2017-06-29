#!/usr/bin/perl
use warnings;
use strict;

#   ===========================================================================
#   Module for working out which cards I need to get for a given deck
#   v1.1
#   ===========================================================================

sub cardstoget {
    my ($rootdir, %opts) = @_;

    #   Load up library and input deck
    my ($linforef, $libref, $libsidref) = codtohashes($opts{"lib"});
    my ($inforef, $deckref, $SBref) = codtohashes($opts{"in"});
    my $qref = deckcombine($deckref, $SBref);       # Combine SB and maindeck
    my %lib = %{$libref};                           # Deref. the library


    #   If list of other decks provided, subtract each from library
    if ($opts{"dlist"}) {
        foreach my $otherdeck (@{$opts{"dlist"}}) {
                my ($OIref, $OMref, $OSBref) = codtohashes($otherdeck);
                my $ODref = deckcombine($OMref, $OSBref);
                my $newlibref = libsubtract($libref, $ODref);
                %lib = %{$newlibref};
        }
    }

    #   Subtract library cards from input deck
    $qref = decksubtract($qref, $libref);
    my %query = %{$qref};                           # Deref. the deck

    #   Print out cards to get from input deck if there are any.
    if (%query) {
        print "\nCards not in library or used in other decks\n"
             ."==================================================\n";
        listprint(%query);
        print "==================================================\n\n"
    } else {
        print "\nAll cards in query deck are in Library and unused.\n\n";
    }

}

#   Sub for removing cards that are used in other decks from the library
sub libsubtract {
    my ($libref, $odeckref) = @_;
    my %library = %{$libref};                       # Deref. the decks
    my %odeck = %{$odeckref};
    foreach my $key (keys(%odeck)) {
        if ($library{$key}) {
            $library{$key} = $library{$key} - $odeck{$key}; # Minus cards
            if ($library{$key} < 1) {
                delete($library{$key});             # Remove if < 1 in library
            }
        }
    }
    return(\%library);
}

1
