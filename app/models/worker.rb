class Worker < ApplicationRecord
  has_many :applications
  has_many :worker_feedbacks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
