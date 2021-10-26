class WorkerFeedback < ApplicationRecord
  belongs_to :user
  belongs_to :worker
  belongs_to :application

  validates :rate, :comment, presence: true
  validates :rate, numericality: {greater_than_or_equal_to: 0}
  validates :rate, numericality: {less_than_or_equal_to: 5}
  validates :comment, length: {maximum: 100}
  validates_uniqueness_of :user, scope: :application_id, message: "você já enviou um feedback para esta aplicação."
end
