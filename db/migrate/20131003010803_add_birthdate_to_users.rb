class AddBirthdateToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :middle_name, :string
    remove_column :users, :full_name, :string
    add_column :users, :birthdate, :datetime
  end
end
