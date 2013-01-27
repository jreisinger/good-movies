#!/usr/bin/perl
use strict;
use warnings;
use autodie;

#
# VARIABLES
#

# cat good_movies.txt | grep Genres | cut -d':' -f2 | sed 's/^ //' | perl -wln\
# -E 'my @genres; push @genres, split; say for sort @genres' | sort | uniq
my @genres = qw(
  Action
  Adventure
  Animation
  Biography
  Comedy
  Crime
  Documentary
  Drama
  Family
  Fantasy
  History
  Horror
  Music
  Musical
  Mystery
  Reality-TV
  Romance
  Sci-Fi
  Short
  Sport
  Talk-Show
  Thriller
  War
  Western
);

my $file  = 'good_movies.txt';
my $genre = shift;

my @movies; # AoH containg movies
my @lines;

#
# MAIN
#

die "Usage: $0 good_movies.txt [ genre ]\n" unless -e $file;

# Parse movie file
open my ($fh), $file;
while (<$fh>) {
    if ( not /^$/ ) {    # empty lines separate movies
        push @lines, $_;
    } else {
        add_movie( \@lines );
        @lines = ();
    }
}
close $fh;

my @sorted = sort {
         $b->{'Raters'} <=> $a->{'Raters'}
      or $b->{'Rating'} <=> $a->{'Rating'}
} @movies;


# Did user ask for a existing genre?
if ( defined $genre ) {
    die "'$genre' is not a movie genre, pick from: @genres\n"
      unless grep { "\L$_" =~ "\L$genre" } @genres;
} else {
    $genre = '.'; # regex meaning any genre (any one char)
}

my $print;
for my $movie (@sorted) {
    for my $key ( keys %{$movie} ) {
        if ( $movie->{'Genres'} =~ /$genre/i ) {
            $print = 1;
        }
    }
    if ($print) {
        print $movie->{'Title'} . " (" . $movie->{'Id'} . ")\n";
        $print = 0;
    }
}

#
# FUNCTIONS
#

sub add_movie {

    # add movie to @movies (AoH)
    my $lines = shift;

    my $movie = {};
    for my $line (@$lines) {
        chomp $line;
        my ( $key, $value ) = split /:/, $line;
        $value =~ s/^\s+//;    # remove whitespace at the beginning
        if ( $key eq 'Rating' ) {
            my ( $rating, $raters ) = split ' ', $value;
            $movie->{'Rating'} = $rating;
            $raters = $1 if $raters =~ /(\d+)/;    # remove braces around raters
            $movie->{'Raters'} = $raters;
        } else {
            $movie->{$key} = $value;
        }
    }
    push @movies, $movie;
}
