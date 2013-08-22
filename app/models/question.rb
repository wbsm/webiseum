class Question < ActiveRecord::Base

	validates_presence_of :title, :description, :answers, :publish_at, :event_at
	validates_uniqueness_of :title

	has_many :forecasts
  	has_many :users, through: :forecasts
  	
  	has_and_belongs_to_many :tags
end
