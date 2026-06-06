class BadgeAward < ApplicationRecord
  belongs_to :user

  validates :badge_key, presence: true, uniqueness: { scope: :user_id }
end
