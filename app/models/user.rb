class User < ApplicationRecord
    has_secure_password
    has_many :scores, dependent: :destroy
    
    validates :name, presence: true
    validates :username, presence: true, length: {minimum: 3, maximum: 10}, uniqueness: { case_sensitive: true }
    validates :password, presence: true
end
