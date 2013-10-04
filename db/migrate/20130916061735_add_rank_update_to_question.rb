class AddRankUpdateToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :rank_update, :boolean
  end
end
