class User < ApplicationRecord
    has_secure_password
    has_many :scores
    
    validates :name, presence: true
    validates :username, presence: true, length: {minimum: 3}
    validates :password, presence: true
    validates :username, uniqueness: { case_sensitive: true }
end
