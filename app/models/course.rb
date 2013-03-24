class Course < ActiveRecord::Base

  before_validation :generate_slug

  default_scope where(:published => true).where("slug is not null")

	validates :name, :presence => true, :length => {:within => 1..30}
  validates :body, :slug, :presence => true

  mount_uploader :avatar, ImageUploader
	
  belongs_to :admin, foreign_key: "creator_id", class_name: 'User'
  has_many :users, through: :courses_members
  has_many :groups_members
  has_many :sections

  has_many :slots

  def to_param
    "#{id}-#{self.slug.parameterize}"
  end

  def member(user)
    CoursesMember.where(user_id: user.id, course_id: self.id).first
  end


  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end


end
