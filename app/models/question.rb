=begin create_table "questions", force: true do |t|
  t.string   "title"
  t.text     "description"
  t.datetime "publish_at"
  t.datetime "finish_at"
  t.datetime "event_at"
  t.text     "answers"
  t.string   "correct_answer"
  t.binary   "image"
  t.datetime "created_at"
  t.datetime "updated_at"
  t.boolean  "rank_update",         default: false, null: false
  t.string   "avatar_file_name"
  t.string   "avatar_content_type"
  t.integer  "avatar_file_size"
  t.datetime "avatar_updated_at"
end
=end
class Question < ActiveRecord::Base
  scope :not_expired, -> { where('? between publish_at and finish_at and rank_update = ?', Time.zone.now.to_s(:db), false).order('finish_at ASC') }
  scope :by_tag, -> (tag_name) { joins(:tags).where('tags.name' => tag_name.downcase) }

  # Paperclip
  has_attached_file :avatar, :styles => { :thumb => "64x64#" }

  # validations
	validates_presence_of :title, :answers, :publish_at, :event_at, :finish_at
	validates_uniqueness_of :title

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
