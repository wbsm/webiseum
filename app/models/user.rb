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

  scope :by_name, -> (user_name) { where('lower(name) like ?', "%#{user_name.downcase}%") }

  # validations
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates_presence_of :first_name, :last_name, :email#, :birthdate, :gender
  validates_uniqueness_of :email
  validates_format_of :email, with: EMAIL_REGEXP
  validates_length_of :password, :minimum => 6

  # Omniauth Identity
  auth_key :email

  # att
  attr_accessor :is_new

  # Paperclip
  has_attached_file :avatar, :styles => { :thumb => "46x46#", :small => "20x20#" }

  def image_type(type)
    if avatar.present?
      avatar.url(type)
    else
      'https://app.divshot.com/img/placeholder-64x64.gif'
    end
  end

	private
    def build_name
      self.name = "#{self.first_name} #{self.last_name}"
    end

  # associations
  has_many :authentications
  has_many :forecasts

  has_many :comments

  has_one :rank
  has_many :tag_ranks
end
	