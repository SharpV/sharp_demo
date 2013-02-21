class Course < ActiveRecord::Base
	validates :name, :presence => true, :length => {:within => 1..30}
  validates :body, :presence => true
  validates :cover, :presence => true
  

  mount_uploader :cover, ImageUploader
	
  belongs_to :user, :foreign_key => "creator_id"

  def to_param
    "#{id}-#{url.parameterize}"
  end


  def generate_slug
    self.url = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
