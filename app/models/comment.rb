class Comment < ActiveRecord::Base

  validates_presence_of :forecast, :user

  # associations
  belongs_to :forecast
  belongs_to :user
end
