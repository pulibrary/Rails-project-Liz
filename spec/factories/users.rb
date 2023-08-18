# frozen_string_literal: true

# sequence is used to generate unique username
FactoryBot.define do
  factory :user do
    name { "name#{srand}" }
    sequence(:username) { "user#{rand(0...10000)}" }
    password { 'xakjs354' }
  end

  factory :score do
    score {86400}
    association :user
  end
end

