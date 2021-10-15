class Job < ApplicationRecord
  belongs_to :user
  validates :title, :description, :skills, :payment, :deadline, presence: true
end
