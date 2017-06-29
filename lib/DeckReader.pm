#!/usr/bin/perl
use warnings;
use strict;

#   ===========================================================================
#   Module for reading a COD file into %maindeck, %sideboard and %info
#   v1.0
#   ===========================================================================

sub codtohashes {
    my ($codfile) = @_;

    #   Throw an error if can't find the file
    if (! -e $codfile) {
        print "ERROR: File not found:\n$codfile\n";
        exit(3);
    }

    #   Grab file into string and remove DOS carriage returns
    my $xmlstring = '';
    open(my $infh, $codfile);
    foreach my $line (<$infh>) {
        $line =~ s/[\r\n]//g;
        $line =~ s/^\s+//;
        $xmlstring = $xmlstring . $line;
    }
    close($infh);

    #   Parse deckfile XML string into a data tree
    my $parser = new XML::Parser(Style => 'Tree');
    my $decktree = $parser->parse($xmlstring);

    #   Store main deck in a hash
    my %maindeck;
    my $mcount = 0;
    foreach my $ref (@{$decktree->[1]->[6]}) {
        if ($mcount != 0 && ($mcount % 2) == 0) {   # Even no.s not 0 = cards
            $maindeck{$ref->[0]{'name'}} = $ref->[0]{'number'};
        }
        $mcount ++;
    }

    #   Store sideboard in a hash
    my %sideboard;
    my $scount = 0;
    foreach my $ref (@{$decktree->[1]->[8]}) {
        if ($scount != 0 && ($scount % 2) == 0) {   # Even no.s not 0 = cards
            $sideboard{$ref->[0]{'name'}} = $ref->[0]{'number'};
        }
        $scount ++;
    }

    #   Store other information in a final hash
    my %deckinfo;
    $deckinfo{'name'} = $decktree->[1]->[2]->[2];
    $deckinfo{'version'} = $decktree->[1]->[0]{'version'};
    if ($decktree->[1]->[4]->[2]) {                 # There may not be comments
        $deckinfo{'comments'} = $decktree->[1]->[4]->[2];
    }

    #   Return hash references
    return(\%deckinfo, \%maindeck, \%sideboard);
}

1
