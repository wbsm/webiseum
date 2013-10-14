class AddTimeZoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string, :default => 'America/Sao_Paulo'
  end
end
