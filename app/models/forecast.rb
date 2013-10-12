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
  scope :order_by_time, -> { order('updated_at DESC') }
  scope :from_user, -> (user_id) { joins(:user).where('users.id = ?', user_id) }

  validates_presence_of :rating, :answer

  # associations
	belongs_to :user
	belongs_to :question

  has_many :comments
end
