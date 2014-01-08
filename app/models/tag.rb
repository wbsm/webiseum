class Tag < ActiveRecord::Base

  # associations
  has_and_belongs_to_many :questions

  has_many :tag_ranks
end
