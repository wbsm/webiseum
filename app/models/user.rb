=begin
  table users

  string   "full_name"
  string   "name"
  string   "email"
  datetime "created_at"
  datetime "updated_at"
  integer  "rank_score",  default: 0, null: false
  string   "first_name"
  string   "middle_name"
  string   "last_name"
  string   "gender"
  binary   "image"
=end
class User < OmniAuth::Identity::Models::ActiveRecord
  before_save :build_name

  auth_key :email

  validates_presence_of :first_name, :last_name, :email#, :birthdate, :gender
  validates_uniqueness_of :email

=begin
	validates_presence_of :name, :last_name, :email
	validates_length_of :full_name, allow_blank: false
	validates_uniqueness_of :email
	validates_format_of :email, with: EMAIL_REGEXP
=end

	private
    def build_name
      self.name = "#{self.first_name} #{self.last_name}"
    end

  # associations
  has_many :authentications
  has_many :forecasts
end
	