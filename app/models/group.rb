 # encoding: utf-8

class Group < ActiveRecord::Base
  # attr_accessible :title, :body
  mount_uploader :avatar, ImageUploader

  paginates_per 18

  scope :webclass, where(is_class: true)

  scope :webgroup, where(is_class: false)


  acts_as_commentable
  acts_as_tagger
  acts_as_taggable_on :tags
  
  validates :name, :presence => true, :length => {:within => 1..30}
  validates :body, :presence => true
  belongs_to :school
  has_many :messages
  has_many :folders, as: :folderable  
  has_many :categories, as: :categoryable
  has_many :exams
  has_many :members
  has_many :users, through: :members
  has_many :courses
  has_many :assignments
  has_many :posts, as: :postable
  has_many :terms
  has_many :media, as: :mediumable
  has_many :slots
  has_many :albums, as: :albumable
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'
  before_validation :set_webclass

  after_create :create_admin, :create_default_category_and_folder, :current_term

  def current_term
    if Date.current > Date.new(Time.now.year, 3, 1) and Date.current <= Date.new(Time.now.year, 8, 1)
      find_or_create_current_term(Time.now.year, 0)
    elsif Date.current > Date.new(Time.now.year, 8, 1) and Date.current <= Date.new(Time.now.year, 12, 31)
      find_or_create_current_term(Time.now.year, 1)
    else
      find_or_create_current_term(Time.now.year-1, 1)
    end
  end

  def teachers
    Member.includes(:user).where role: 'teacher', group_id: self.id
  end

  def group_members(role)
    members.includes(:user).select{|m|m.role == role.to_s and m.active}
  end

  def title
    is_class ? "班级" : "小组"
  end

  def school_name
    school ? school.name : ''
  end

  private

  def find_or_create_current_term(year, part)
    terms.where(year:Time.now.year, part:0).first || Term.create(group: self, year: year, part: 0, creator: self.creator)
  end


  def create_default_category_and_folder
    folder = self.folders.build name: '默认目录'
    category = self.categories.build name: '默认分类'
    folder.save and category.save
  end

  def create_admin
    Member.create group_id: self.id, user_id: self.creator_id, admin: true, active: true
  end
  
  def set_webclass
    self.is_class = true if self.school_id
  end

  class << self

    def latest_groups
      Group.webgroup.order('created_at desc').limit(10)
    end

    def hot_groups
      Group.webgroup.order('readings_count desc').limit(10)
    end

    def hot_topics
      Post.where(postable_type: Group.to_s).order('comments_count desc').limit(10)
    end

    def hot_media
      Medium.where(mediumable_type: Group.to_s).order('downloads_count desc').limit(10)
    end

    def hot_webclasses
      Group.webclass.order('readings_count desc').limit(10)
    end

    def latest_webclasses
      Group.webclass.order('created_at desc').limit(20)
    end

  end
end
