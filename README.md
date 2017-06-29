# MTG-Deckutils
A command-line toolkit for handling deck files. Feature building is happening now, and a more user-friendly web interface will be developed later.




## Introduction







## Installation
### Installation Requirements
1. A Unix-based operating system (E.G.: Linux, Mac OSX) with BASH installed and running
2. Perl v5.24.1 or later




### Installation
1. Clone/download the repository to your local machine.
2. Navigate to MTG-deckutils/bin
3. Launch ./deckutils.pl


### Optional
If you are running BASH on your machine and are familiar with launchers, you can make life easier for you.

1. In the root of this repository, there is the "deckutils" file, which contains a BASH launcher. Edit the file and replace "Your_Path_Here" with the full path to the "MTG-deckutils/bin" directory.
2. Move the file to a directory which is in your $PATH.

## Usage
### Synopsis



### Options
toget       Create a shopping list of the cards that are in a deck which either
            are not in your library or are in use in other decks.
            
            Usage:
            
            deckutils toget -i deckname.cod -l library.cod [-v] [-d deck1.cod
            deck2.cod deck3.cod]

    -d --decklist   List of other decks that take up cards from your library.
                    Useful if you don't want to dismantle other decks to make
                    your new one.
    -l --lib        Path to library COD file containing all of your cards
    -v --verbose    Verbose output (Does nothing at the moment)

deckdiff    Creates a list of cards that are in both decks, and lists of cards
            that are unique to each deck.
            
            Usage:
            
            deckutils deckdiff --d1 deck1.cod --d2 deck2.cod [--sideboard]

    -s --sideboard  Include sideboard in the lists of cards in each deck so
                    that each output list is more complete.
