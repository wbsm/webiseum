class AddRankUpdateDefaultValueToQuestionSteps < ActiveRecord::Migration
  def change
    change_column :questions, :rank_update, :boolean, :default => false, :null => false
  end
end
