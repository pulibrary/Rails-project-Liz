# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


ActiveRecord::Base.connection.execute(
    "INSERT INTO scores (datetime, score, user_id, created_at, updated_at)
     VALUES (NOW(), '100', '1', NOW(), NOW())"
  )

  ActiveRecord::Base.connection.execute(
    "INSERT INTO scores (datetime, score, user_id, created_at, updated_at)
     VALUES ('2023-07-25 08:30:15', '90', '2', NOW(), NOW())"
  )

  ActiveRecord::Base.connection.execute(
    "INSERT INTO scores (datetime, score, user_id, created_at, updated_at)
     VALUES ('2023-07-20 09:30:15', '80', '3', NOW(), NOW())"
  )
  
  
  