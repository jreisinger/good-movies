# Good movies

Find good movies via [IMDB API](http://imdbapi.org/).

## Usage

1. Run `good_movies.pl`, it will search <http://www.imdb.com> and store good movies to
`good_movies.txt`. It does that by randomly picking up a movie ID and
considering its rating and number of people who rated. The already checked
movies IDs are stored to `seen_ids.txt` so they are not checked again.

1. After a while, run `parse_good_movies.pl good_movies.txt [ genre ]`. It will sort the
good movies from best to worst, optionally printing just movies of certain
genre.

