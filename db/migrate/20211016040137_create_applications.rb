class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.string :description
      t.decimal :payment
      t.integer :time_per_week
      t.datetime :expected_deadline
      t.references :job, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
