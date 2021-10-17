class UserFeedback < ApplicationRecord
  belongs_to :user
  belongs_to :worker
  belongs_to :job
end
