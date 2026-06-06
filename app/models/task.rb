class Task < ApplicationRecord
  STATUSES = %w[inbox active completed archived].freeze
  PRIORITIES = %w[low normal high urgent].freeze

  belongs_to :user
  belongs_to :project, optional: true
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  has_many :xp_events, dependent: :nullify

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  scope :open, -> { where.not(status: "completed") }
  scope :completed, -> { where(status: "completed") }
  scope :inbox, -> { where(status: "inbox") }
  scope :today, -> { open.where(due_at: Time.current.beginning_of_day..Time.current.end_of_day) }
  scope :week, -> { open.where(due_at: Time.current.beginning_of_day..1.week.from_now.end_of_day) }
  scope :overdue, -> { open.where("due_at < ?", Time.current.beginning_of_day) }

  before_validation :default_values

  def complete!
    return if completed?

    transaction do
      update!(status: "completed", completed_at: Time.current)
      XpLedger.award!(user:, task: self, points: completion_points, reason: "complete_task")
      BadgeLedger.sync_for!(user)
    end
  end

  def completed?
    status == "completed"
  end

  def completion_points
    base = { "low" => 8, "normal" => 12, "high" => 18, "urgent" => 25 }.fetch(priority, 12)
    due_at.present? && due_at >= Time.current ? base + 5 : base
  end

  private

  def default_values
    self.status ||= "inbox"
    self.priority ||= "normal"
  end
end
