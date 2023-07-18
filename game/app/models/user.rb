class User < ApplicationRecord
    validates :name, presence: true
    validates :username, presence: true, length: {minimum: 5}
end