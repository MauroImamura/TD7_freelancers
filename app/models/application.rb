class Application < ApplicationRecord
  belongs_to :job
  belongs_to :worker
  has_many :worker_feedbacks
  validates :description, :payment, :time_per_week, :expected_deadline, presence: true
  validates :description, length: {maximum: 100}
  validates :payment, numericality: {greater_than: 0}
  validate :expected_deadline_is_feasible
  validates_uniqueness_of :worker, scope: :job_id, conditions: -> { where.not(status: 'canceled') }, message: "você já enviou uma proposta. Cancele a atual antes de mandar uma nova."

  enum status: {refused: 00, canceled: 3, pending: 5, accepted: 10}

  private

  def expected_deadline_is_feasible
    if expected_deadline != nil && expected_deadline <= Date.today
      errors.add(:expected_deadline, 'inválida, escolha uma data a partir de hoje.')
    end
  end
end
