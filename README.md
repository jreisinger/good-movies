# Good movies

Find good movies via [IMDB API](http://imdbapi.org/).

## Usage

Run `good_movies.pl` to search <http://www.imdb.com> and store good movies to
`good_movies.txt`. It's done by randomly picking up a movie ID and considering
its rating and number of people who rated. The already checked movies IDs are
stored to `seen_ids.txt` so they are not checked again.

Run `parse_good_movies.pl good_movies.txt [ genre ]` to sort and print the good
movies from best to worst, optionally printing just movies of certain genre.

