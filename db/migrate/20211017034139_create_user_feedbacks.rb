class CreateUserFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_feedbacks do |t|
      t.integer :rate
      t.string :comment
      t.references :user, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
