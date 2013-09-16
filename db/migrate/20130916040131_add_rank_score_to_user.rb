class AddRankScoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :rank_score, :integer, :default => 0, null: false
  end
end
