class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :nullify

  COLORS = %w[#1f7a8c #bf4342 #5c6f68 #f0a202 #6a4c93 #2f9c95].freeze

  validates :name, presence: true
  validates :color, presence: true
end
