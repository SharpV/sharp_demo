 # encoding: utf-8

class Group < ActiveRecord::Base

  mount_uploader :avatar, ImageUploader
  acts_as_taggable_on :tags

  belongs_to :admin, foreign_key: "creator_id", class_name: 'User'
  has_many :members, as: :memberable
  has_many :users, through: :members
  has_many :folders, as: :folderable  
  has_many :categories, as: :categoryable

  has_many :posts, as: :postable
  has_many :media, as: :mediumable
  
  belongs_to :creator,  :class_name => "User"
  
  before_validation :generate_slug

  after_create :create_admin, :create_default_category_and_folder

  validates :name, :length => {
    :minimum   => 1,
    :maximum   => 30,
  }

  def to_param
    slug ? "#{id}-#{slug.parameterize}" : id.to_s
  end

  private

  def create_default_category_and_folder
    folder = self.folders.build name: '默认目录'
    category = self.categories.build name: '默认分类'
    folder.save and category.save
  end

  def create_admin
    Member.create memberable: self, user: self.creator, admin: true, active: true
  end
  
  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
