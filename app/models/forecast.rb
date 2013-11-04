=begin
create_table "forecasts", force: true do |t|
    t.integer  "rating"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "answer"
  end
=end
class Forecast < ActiveRecord::Base
  include ForecastMatch

  scope :order_by_time, -> { order('updated_at DESC') }
  scope :by_user_id, -> (user_id) { where(:user_id => user_id) }
  scope :by_user_name, -> (user_name) { joins(:user).where('users.name like ?', "%#{user_name}%") }
  #scope :by_tag, -> (tag_name) { joins(question: :tags).where('lower(tags.name) = ?', tag_name.downcase).distinct(:question) }
  scope :by_tag, -> (tag_name) { joins(question: :tags).where('lower(tags.name) = ?', tag_name.downcase) }

  validates_presence_of :rating, :answer

  # associations
	belongs_to :user
	belongs_to :question

  has_many :comments
end
