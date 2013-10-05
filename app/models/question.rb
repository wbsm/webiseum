class Question < ActiveRecord::Base

  # Paperclip
  has_attached_file :avatar, :styles => { :thumb => "64x64#" }

  # validations
	validates_presence_of :title, :answers, :publish_at, :event_at, :finish_at
	validates_uniqueness_of :title

	def self.find_not_expired
    where("finish_at > ?", Time.now.to_s(:db)).order("finish_at ASC")
  end

  def image_type(type)
    if avatar.present?
      avatar.url(type)
    else
      'https://app.divshot.com/img/placeholder-64x64.gif'
    end
  end

  # associations
  has_many :forecasts
  has_many :users, through: :forecasts

  has_and_belongs_to_many :tags
end
