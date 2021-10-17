class FavoritedWorker < ApplicationRecord
  belongs_to :user
  belongs_to :worker
end
