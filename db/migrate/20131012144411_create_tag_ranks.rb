class CreateTagRanks < ActiveRecord::Migration
  def change
    create_table :tag_ranks do |t|
      t.integer :score
      t.belongs_to :user, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
