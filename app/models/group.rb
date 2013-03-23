class Group < ActiveRecord::Base

  mount_uploader :avatar, ImageUploader
  acts_as_taggable_on :tags

  #belongs_to :user, foreign_key: :creator_id
  has_many :users, through: :groups_members
  has_many :groups_members

  belongs_to :grade
  
  has_many :topics
  has_many :categories
  has_many :questions

  belongs_to :creator,  :class_name => "User"
  
  before_validation :generate_slug

  after_save :create_admin

  #def to_param
   # "#{id}-#{slug.parameterize}"
  #end


  private

  def create_admin
    GroupsMember.create group: self, user: self.creator, admin: true, active: true
  end
  
  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
