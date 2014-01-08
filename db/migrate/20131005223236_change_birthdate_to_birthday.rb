class ChangeBirthdateToBirthday < ActiveRecord::Migration
  def change
    remove_column :users, :birthdate, :date
    add_column :users, :birthday, :date
  end
end
