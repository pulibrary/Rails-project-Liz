FactoryBot.define do
    factory :user do
      name { 'Pedro' }
      username { 'pedro111' }     
      password { 'xakjs354' }

      factory :score do
        score { '100' }
      end
    end
  end
