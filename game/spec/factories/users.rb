# frozen_string_literal: true

# sequence is used to generate unique username
FactoryBot.define do
  factory :user do
    name { "name#{srand}" }
    sequence(:username) { "user#{rand(10000)}" }
    password { 'xakjs354' }
  end
end

