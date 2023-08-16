class Score < ApplicationRecord
  belongs_to :user

  validates :score, presence: true
  validates :user_id, uniqueness: true
end
