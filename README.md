# Good movies

Find good movies via imdb.com API.

## Usage

1. Run `good_movies.pl`, it will search imdb.com and store good movies to
`good_movies.txt`. It does that by randomly picking up a movie ID and
considering it rating and number of people who rated. The already checked
movies IDs are stored to `seen_ids.txt`.

1. Run `parse_good_movies.pl good_movies.txt [ genre ]`. It will sort the
good movies from best to worst, optionally printing just movies of certain
genre.

