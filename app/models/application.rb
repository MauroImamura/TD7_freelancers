class Application < ApplicationRecord
  belongs_to :job
  belongs_to :worker
  validates :description, :payment, :time_per_week, :expected_deadline, presence: true
  validates :description, length: {maximum: 100}
  validates :payment, numericality: {greater_than: 0}
  validate :expected_deadline_is_feasible

  private

  def expected_deadline_is_feasible
    if expected_deadline != nil && expected_deadline <= Date.today
      errors.add(:expected_deadline, 'inválida, escolha uma data a partir de hoje.')
    end
  end
end
