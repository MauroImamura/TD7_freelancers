class Worker < ApplicationRecord
  has_many :applications
  has_many :worker_feedbacks
  has_many :user_feedbacks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
