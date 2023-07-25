# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { "name#{srand}" }
    sequence(:username) { "username#{srand}" }
    password { 'xakjs354' }
  end
end
