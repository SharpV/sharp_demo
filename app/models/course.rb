class Course < ActiveRecord::Base
	validates :name, :presence => true, :length => {:within => 1..100}
  validates :body, :presence => true
  validates :cover, :presence => true
  

  mount_uploader :cover, ImageUploader
	
  belongs_to :user, :foreign_key => "creator_id"

end
