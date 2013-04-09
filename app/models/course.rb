class Course < ActiveRecord::Base

  before_validation :generate_slug

  default_scope where(:published => true).where("slug is not null")

	validates :name, :presence => true, :length => {:within => 1..30}
  validates :body, :slug, :presence => true

  mount_uploader :avatar, ImageUploader
	  
  has_many :categories, as: :categoryable
  has_many :folders, as: :folderable
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'
  has_many :users, through: :courses_members
  has_many :sections, order: :position
  has_many :slots, order: :created_at

  def to_param
    slug ? "#{id}-#{slug.parameterize}" : id.to_s
  end

  def member(user)
    CoursesMember.where(user_id: user.id, course_id: self.id).first
  end


  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end


end
