# note: both users and scores table have created_at and updated_at columns, but we only make use of the created_at in the scores table, thus I have only showed that column in scores.

USERS table

id                name           username      password_digest                                  
(integer)         (string)       (string)                                           
----------------------------------------------------------------------
1                Liz Garcia       lizgarcia       liz123                     
2                Toby Happy       toby10          toby123                            


SCORES table

user_id           score               created_at                                   
(integer)         (integer)           (timestamp)                                      
---------------------------------------------------------------------------------
1                 2456 pts         2023-07-17T12:30:45-04:00      
2                 1345 pts         2023-07-17T11:30:45-04:00




3 Example SQL Queries Needed:

1- Top 5 players of all time:
`SELECT users.name, users.username, scores.score, scores.datetime FROM users INNER JOIN scores ON users.id = scores.user_id ORDER BY scores.score DESC, scores.datetime DESC LIMIT 5; ` 
2-Top 5 players in 2023 only:
`SELECT users.name, users.username, scores.score, scores.datetime FROM users INNER JOIN scores ON users.id = scores.user_id ORDER BY scores.score DESC, scores.datetime DESC WHERE scores.date LIKE "2023%" LIMIT 5; `
3- List of all players in alphabetical order:
`SELECT users.name, users.username, scores.score, scores.datetime FROM users INNER JOIN scores ON users.id = scores.user_id ORDER BY users.name ASC;` 