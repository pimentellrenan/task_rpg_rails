class XpEvent < ApplicationRecord
  belongs_to :user
  belongs_to :task, optional: true

  validates :points, numericality: { only_integer: true }
  validates :reason, presence: true
end
