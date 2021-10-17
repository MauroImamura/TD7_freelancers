class WorkerFeedback < ApplicationRecord
  belongs_to :user
  belongs_to :worker
  belongs_to :application
end
