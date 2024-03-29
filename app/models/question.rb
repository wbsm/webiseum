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
  scope :ordered, -> { all.order('finish_at DESC') }
  scope :not_expired, -> { where('? between publish_at and event_at', Time.zone.now.to_s(:db)).order('finish_at ASC') }
  scope :not_ranked, -> { where('rank_update = ?', false).order('finish_at ASC') }
  scope :by_tag, -> (tag_name) { joins(:tags).where('lower(tags.name) = ?', tag_name.downcase) }
  #scope :not_forecasted, -> (user_id) { includes(:forecasts).where('forecasts.user_id != ?', user_id).references(:forecasts) }
  #scope :not_forecasted, -> (user_id) { joins('INNER JOIN forecasts ON forecasts.question_id != questions.id').where('forecasts.user_id == ?', user_id) }

  # Paperclip
  has_attached_file :avatar, :styles => { :thumb => "160x80#", :small => "80x40#" }

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

  def not_expired
    time_zone_now_to_s = Time.zone.now.to_s(:db)
    time_zone_now_to_s >= self.publish_at and time_zone_now_to_s <= self.event_at
  end

  # associations
  has_many :forecasts, order: 'updated_at DESC'
  has_many :users, through: :forecasts

  has_and_belongs_to_many :tags
end
