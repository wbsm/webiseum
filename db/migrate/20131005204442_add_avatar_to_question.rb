class AddAvatarToQuestion < ActiveRecord::Migration
  def self.up
    add_attachment :questions, :avatar
  end

  def self.down
    remove_attachment :questions, :avatar
  end
end
