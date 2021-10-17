class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :jobs
  has_many :worker_feedbacks
  has_many :user_feedbacks
  has_many :favorited_workers
end
