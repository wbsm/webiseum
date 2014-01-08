class ChangeScoreToRank < ActiveRecord::Migration
  def change
    change_column :ranks, :score, :integer, :default => 0
    change_column :tag_ranks, :score, :integer, :default => 0
  end
end
