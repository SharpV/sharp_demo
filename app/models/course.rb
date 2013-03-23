class Course < ActiveRecord::Base

  before_validation :generate_slug

  default_scope where(:published => true).where("slug is not null")

	validates :name, :presence => true, :length => {:within => 1..30}
  validates :body, :slug, :presence => true

  mount_uploader :avatar, ImageUploader
	
  belongs_to :user, :foreign_key => "creator_id"

  def to_param
    "#{id}-#{self.slug.parameterize}"
  end


  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end


end
