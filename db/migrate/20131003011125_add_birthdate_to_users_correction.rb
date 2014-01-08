class AddBirthdateToUsersCorrection < ActiveRecord::Migration
  def change
    remove_column :users, :birthdate, :date
    add_column :users, :birthdate, :date
  end
end
