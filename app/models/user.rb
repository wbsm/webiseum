class User < ActiveRecord::Base

	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	validates_presence_of :full_name, :email
	validates_length_of :full_name, allow_blank: false
	validates_uniqueness_of :email
	validates_format_of :email, with: EMAIL_REGEXP
	
	has_secure_password

	has_many :forecasts
  	has_many :questions, through: :forecasts

end
	