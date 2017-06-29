#!/usr/bin/perl
use warnings;
use strict;

#   ===========================================================================
#   Container for all of the maths functions between 2 decks
#   v1.0
#   ===========================================================================

#   Subroutine for adding 2 hashes with numerical values together
sub deckcombine {
    my ($deck1ref, $deck2ref) = @_;
    my %deck1 = %{$deck1ref};                       # Deref. each deck
    my %deck2 = %{$deck2ref};

    foreach my $key (keys(%deck2)) {
        if ($deck1{$key}) {                         # the maths
            $deck1{$key} = $deck1{$key} + $deck2{$key};
        } else {
            $deck1{$key} = $deck2{$key};
        }
    }
    return(\%deck1);
}

#   Sub for removing cards that are used in other decks from the library
sub decksubtract {
    my ($deckaref, $deckbref) = @_;

    #   Deref. the decks
    my %decka = %{$deckaref};
    my %deckb = %{$deckbref};

    #   Subtract each deck from the other
    foreach my $key (keys(%decka)) {
        if ($deckb{$key}) {
            $decka{$key} = $decka{$key} - $deckb{$key}; # Minus cards
            if ($decka{$key} < 1) {
                delete($decka{$key});             # Remove if < 1 in deck A
            }
        }
    }
    return(\%decka);
}

#   Sub for working out which cards are in both decks
sub deckintersect {
    my ($deckaref, $deckbref) = @_;

    #   Deref. the decks
    my %decka = %{$deckaref};
    my %deckb = %{$deckbref};

    #   Which cards in deck A are also in deck b? delete all others
    foreach my $key (keys(%decka)) {
        if (!$deckb{$key}) {                    # delete if no card in deck B
            delete($decka{$key});
            next;
        } elsif ($decka{$key} > $deckb{$key}) { # Take smaller of 2 card no.s
            $decka{$key} = $deckb{$key};
        }
    }
    return(\%decka);
}

1
