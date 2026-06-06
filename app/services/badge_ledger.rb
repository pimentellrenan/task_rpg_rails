class BadgeLedger
  BADGES = {
    "first_clear" => "Primeiro abate",
    "ten_done" => "Dez pendencias domadas",
    "inbox_zero" => "Mente limpa",
    "streak_3" => "Motor quente"
  }.freeze

  def self.sync_for!(user)
    award(user, "first_clear") if user.tasks.completed.exists?
    award(user, "ten_done") if user.tasks.completed.count >= 10
    award(user, "inbox_zero") if user.tasks.inbox.none?
    award(user, "streak_3") if user.current_streak >= 3
  end

  def self.award(user, key)
    user.badge_awards.find_or_create_by!(badge_key: key) do |badge|
      badge.awarded_at = Time.current
    end
  end
end
