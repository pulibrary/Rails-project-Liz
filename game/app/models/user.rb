class User < ApplicationRecord
    has_secure_password
    has_many :scores
    
    validates :name, presence: true
    validates :username, presence: true, length: {minimum: 5}
    validates :password, presence: true
end
