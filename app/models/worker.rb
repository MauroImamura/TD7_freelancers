class Worker < ApplicationRecord
  has_many :applications
  has_many :worker_feedbacks
  has_many :user_feedbacks
  has_many :favorited_workers
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
