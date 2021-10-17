class AddApplicationToWorkerFeedback < ActiveRecord::Migration[6.1]
  def change
    add_reference :worker_feedbacks, :application, null: false, foreign_key: true
  end
end
