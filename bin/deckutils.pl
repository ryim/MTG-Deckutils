#!/usr/bin/perl
#   Version 1.2
#   This software is provided as is with no warranty or guarantee of fitness
#   for purpose.

#   ===========================================================================
#   What this generic launcher does
#   ------------------------------------------
#   Checks command given in $ARGV[0] for validity and required options.
#   Launches the relevant subroutine for the given command.
#
#   ===========================================================================

#   Normal modules/pragmas that should come with your Perl installation
use warnings;
use strict;
use FindBin;
use Getopt::Long;
Getopt::Long::Configure ("bundling");
use lib "$FindBin::Bin/../lib";             # Find the lib of modules
use XML::Parser;

#   List of package-specific modules for general use
use CheckDependencies;
use CurrentTime;
use CmdCheck;                               # Check cmds for required options
use DeckReader;                             # Reads COD files into hashes
use ListPrint;                              # Print a hash in a pretty way
use DeckMaths;                              # Maths functions for deck lists
use ToGet;                                  # toget tool
use DeckDiff;                               # deckdiff tool

#   Preparation phase
(my $rootdir = $FindBin::Bin) =~ s/(.*\/).*?$/$1/;      # Locate root dir
(my $cmdrootdir = $rootdir) =~ s/([\ \,\#\"\'\$\%\^\&\(\)\@\?])/\\$1/g;
checkdependencies($rootdir);                            # Check dependencies

#   Parse in options
my %opts;                                               # Store options in hash
GetOptions(
            "l|lib=s" => \$opts{"lib"},                 # Card library
            "d|decklist=s" => \@{$opts{"dlist"}},       # Other decks
            "i|in=s" => \$opts{"in"},                   # Deck to query
            "d1|deck1=s" => \$opts{"d1"},               # Deck 1 query
            "d2|deck2=s" => \$opts{"d2"},               # Deck 2 query
            "s|sideboard" => \$opts{"sideboard"},       # include sideboard
            "h|help" => \$opts{"help"},
            "v|verbose" => \$opts{"v"}                  # Verbosity flag
);

#   Help requested (Overrides all other commands and options)
if ($opts{"help"}) {
    system("cat $cmdrootdir/doc/commandlist.txt");
    exit(0);
}

#   Have they given a command? (initial idiotproofing)
if (! $ARGV[0]) {
    print "ERROR: No command listed\n"
         ."Correct usage:\tdeckutils COMMAND [options]\n\n";
    system("cat $cmdrootdir/doc/commandlist.txt");
    exit(1);
}
my $cmd = $ARGV[0];

#   Check if required options present for the current cmd (more idiotproofing)
checkvalidcmd($cmdrootdir, $cmd, %opts);

#   Run the required command with options
if ($cmd eq "toget") {
    cardstoget($rootdir, %opts);                # Run the module
} elsif ($cmd eq "deckdiff") {
    deckdiff($rootdir, %opts);                  # Run the module
}
