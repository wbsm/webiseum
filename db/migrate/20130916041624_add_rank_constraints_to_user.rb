class AddRankConstraintsToUser < ActiveRecord::Migration
  def change
    change_column :users, :rank_score, :integer, :default => 0, :null => false
  end
end
