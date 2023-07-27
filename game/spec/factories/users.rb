# frozen_string_literal: true

# sequence is used to generate unique username
FactoryBot.define do
  factory :user do
    name { "name#{srand}" }
    sequence(:username) { "username#{rand}" }
    password { 'xakjs354' }
  end
end

