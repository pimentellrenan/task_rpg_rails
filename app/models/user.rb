class User < ApplicationRecord
  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :xp_events, dependent: :destroy
  has_many :badge_awards, dependent: :destroy
  has_many :daily_stats, dependent: :destroy

  before_validation :ensure_api_token, on: :create

  validates :email, presence: true, uniqueness: true

  def total_xp
    xp_events.sum(:points)
  end

  def level
    (Math.sqrt(total_xp / 80.0).floor + 1).clamp(1, 99)
  end

  def xp_for_next_level
    (level**2 * 80) - total_xp
  end

  def current_streak
    days = daily_stats.where("completed_count > 0").pluck(:date)
    streak = 0
    cursor = Date.current
    cursor -= 1.day unless days.include?(cursor)

    while days.include?(cursor)
      streak += 1
      cursor -= 1.day
    end

    streak
  end

  private

  def ensure_api_token
    self.api_token ||= SecureRandom.hex(24)
  end
end
