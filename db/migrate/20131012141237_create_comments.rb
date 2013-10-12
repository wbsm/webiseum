class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.belongs_to :forecast, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
