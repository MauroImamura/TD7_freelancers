class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.string :skills
      t.decimal :payment
      t.datetime :deadline
      t.boolean :in_person
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
