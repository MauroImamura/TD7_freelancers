class Job < ApplicationRecord
  belongs_to :user
  validates :title, :description, :skills, :payment, :deadline, presence: true
  validates :title, uniqueness: true, length: {maximum: 50}
  validates :description, length: {maximum: 120}
  validates :payment, numericality: {greater_than: 0}
  validate :deadline_is_feasible

  private

  def deadline_is_feasible
    if deadline != nil && deadline <= Date.today
      errors.add(:deadline, 'inválida, escolha uma data a partir de hoje.')
    end
  end
end
