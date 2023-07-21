# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# ActiveRecord::Base.connection.execute(
#     "INSERT INTO scores (score, user_id, created_at, updated_at)
#      VALUES ('101', '7', NOW(), NOW())"
#   )

# Delete user and related scores
  user = User.find(10)
  user.destroy if user
  Score.where(user_id: 10).delete_all


#   ActiveRecord::Base.connection.execute(
#     "INSERT INTO scores (score, user_id, created_at, updated_at)
#      VALUES ('90', '2', NOW(), NOW())"
#   )

#   ActiveRecord::Base.connection.execute(
#     "INSERT INTO scores (datetime, score, user_id, created_at, updated_at)
#      VALUES ('80', '3', NOW(), NOW())"
#   )
  
  
  