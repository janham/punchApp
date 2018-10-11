class Punch < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :punch_at_in, presence: true
  validates :status, presence: true
end
