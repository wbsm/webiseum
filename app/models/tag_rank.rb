class TagRank < ActiveRecord::Base
  scope :by_tag, -> (tag_name) { joins(:tag).order('score desc').where('lower(tags.name) = ?', tag_name) }
  
  #associations	
  belongs_to :user
  belongs_to :tag
end
