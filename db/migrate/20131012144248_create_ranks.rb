class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :score
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
