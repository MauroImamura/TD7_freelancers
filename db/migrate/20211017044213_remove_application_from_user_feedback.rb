class RemoveApplicationFromUserFeedback < ActiveRecord::Migration[6.1]
  def change
    remove_reference :user_feedbacks, :application, null: false, foreign_key: true
  end
end
