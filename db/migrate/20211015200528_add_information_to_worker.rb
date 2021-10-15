class AddInformationToWorker < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :full_name, :string
    add_column :workers, :social_name, :string
    add_column :workers, :birth_date, :datetime
    add_column :workers, :education, :string
    add_column :workers, :description, :string
    add_column :workers, :experience, :string
  end
end
