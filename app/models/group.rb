class Group < ActiveRecord::Base

  mount_uploader :avatar, ImageUploader
  acts_as_taggable_on :tags

  belongs_to :admin, foreign_key: "creator_id", class_name: 'User'
  has_many :users, through: :groups_members
  has_many :groups_members
  has_many :folders, as: :folderable  
  has_many :group_topics
  has_many :categories, as: :categoryable

  belongs_to :creator,  :class_name => "User"
  
  before_validation :generate_slug

  after_save :create_admin

  def to_param
    slug ? "#{id}-#{slug.parameterize}" : id.to_s
  end

  def member(user)
    GroupsMember.where(user_id: user.id, group_id: self.id).first
  end

  private

  def create_admin
    GroupsMember.create group: self, user: self.creator, admin: true, active: true
  end
  
  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
