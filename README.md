# Setup

With provided Rails app:
1. `cd` into the rails-skeleton folder.
2. `bundle` to install all the required Ruby gems.
3. `bundle exec rake db:seeds` to seed your database


# Problem to Solve

The database is populated with game data at the end of the season for the NHL. The data is in the "games" table with the columns:

- away_team_name
- away_team_score
- home_team_name
- home_team_score

With this data, we want to present the end-of-season standings for the NHL. Provide an API endpoint for our mobile clients that gives them the teams in a list with their wins, losses, ties, and position in the standings as JSON.

The teams are ranked as follows

- Top teams have the most wins
- Teams with the same number of wins are then ranked by number of ties

See `sample_api_response.json` for an example of what your response should look like.

# Solution of above problem

http://localhost:3000/games