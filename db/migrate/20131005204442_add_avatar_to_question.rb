class AddAvatarToQuestion < ActiveRecord::Migration
  def self.up
    add_attachment :question, :avatar
  end

  def self.down
    remove_attachment :question, :avatar
  end
end
