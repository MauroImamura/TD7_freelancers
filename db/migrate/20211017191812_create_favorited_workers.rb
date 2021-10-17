class CreateFavoritedWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :favorited_workers do |t|
      t.boolean :checked, default: false
      t.references :user, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
