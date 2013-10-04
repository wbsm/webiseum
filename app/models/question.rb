class Question < ActiveRecord::Base

	validates_presence_of :title, :answers, :publish_at, :event_at, :finish_at
	validates_uniqueness_of :title

	has_many :forecasts
  has_many :users, through: :forecasts

  has_and_belongs_to_many :tags

  def self.find_not_expired
    where("finish_at > ?", Time.now.to_s(:db)).order("finish_at ASC")
  end
end
