# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Command to execute file: 
# $ bundle exec rails db:seed


# Destroy all previous records
Score.destroy_all
User.destroy_all

# User data
users_data = [
  { name: 'Christina', username: 'christina', password: '123'},
  { name: 'Liz', username: 'liz', password: '123' },
  { name: 'Pablo', username: 'pablo1', password: '123' },
  { name: 'Pablo', username: 'pablo2', password: '123' },
  { name: 'Mer', username: 'mer', password: '123' },
  { name: 'Apple', username: 'apple', password: '123' },
  { name: 'Blossom', username: 'blossom', password: '123' },
  { name: 'Winter', username: 'winter', password: '123' },
  { name: 'Pie', username: 'pie', password: '123' },
  { name: 'Sparkle', username: 'sparkle', password: '123' },
  { name: 'Cake', username: 'cake', password: '123' },
]

# Create users and scores
users_data.each do |user_data|
  user = User.create!(user_data)

  10.times do 
    Score.create!(score: rand(0..150), user_id: user.id)
  end

  Score.create!(score: 100, user_id: user.id, updated_at: "2022-02-12")
  Score.create!(score: 100, user_id: user.id)
end


  