**Welcome to Liz's Connect4 Game!**

This website consists of 4 main pages:
1. **Home**: welcomes all users, provides instructions to use website, and gives users access to play the Connect4 game. 
2. **ScoreBoard**: displays top 10 players with most wins in a day, of all time!
3. **Profile**: displays history of scores for logged-in user from highest to lowest (left to right), along with the date on which the score was achieved.
   By logging into their profile, users can edit their account information and delete their account.
5. **List of players**: displays information, such as name, username, and highest individual score (if any) for all users who have created an account.

**I hope you have fun!**

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Technical details about application:**

* Ruby version:
"3.2.2"

* Database: 
postgreSQL

* To run application locally (in case free Render deployment expires):
$ bin/rails s

* How to run the test suite:
$ bundle exec rspec [path of test file]

* Database initialization (to populate website):
$ bundle exec rails db:seed

* Deployment:
Render
  1. In bin/render-build.sh, uncomment "bundle exec rails db:seed" to populate database from scratch.
