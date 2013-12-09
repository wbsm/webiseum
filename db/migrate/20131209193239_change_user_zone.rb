class ChangeUserZone < ActiveRecord::Migration
  def change
    change_column :users, :time_zone, :string, :default => 'Brasilia'
  end
end
