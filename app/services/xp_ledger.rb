class XpLedger
  def self.award!(user:, points:, reason:, task: nil)
    return if task && task.xp_events.exists?(reason:)

    user.xp_events.create!(task:, points:, reason:, happened_at: Time.current)
    stat = user.daily_stats.find_or_initialize_by(date: Date.current)
    stat.completed_count ||= 0
    stat.xp_total ||= 0
    stat.completed_count += 1 if reason == "complete_task"
    stat.xp_total += points
    stat.save!
  end
end
