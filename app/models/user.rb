#encoding: utf-8

require 'digest/sha1'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar,  ImageUploader
  has_many :documents
  has_many :groups
  has_many :posts
  has_many :tasks
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, 
    :province_code, :city_code, :nickname, :field_id
  
  # Validations
  validates_presence_of :password
  validates_presence_of :email, :presence => true, :uniqueness => true
  validates_presence_of :password, :presence => true, :length => {:within => 6..50}
  validates :login, :presence => true, :length => {:within => 5..50}, :uniqueness => true, :format => {:with => /\A\w+\z/, :message => '只允许数字、大小写字母和下划线'}
    
  before_validation :update_login
  
  def flow
      #tag_ids = subscriptions.select(:tag_id).to_sql
      #group_ids = groups.select(:id).to_sql
      #conditions = []
      #conditions << "taggings.tag_id in (#{tag_ids})"
      #conditions << "posts.group_id in (#{user_ids})"
      #Post.joins(:users).where(conditions.join(' or ')).uniq
    end
  
    
  def update_login
    self.login = Digest::SHA1.hexdigest("#{email}#{Time.now}") unless self.login
  end
  
  def stream
    Post.where(:id => posts.select(:id))
  end

  def init_category!
    if note_categories.empty?
      NoteCategory.create :name => "所有分类", :user => self
    end
  end

  def root_category
    NoteCategory.where("user_id=? and parent_id=?", id, nil).first
  end

  def to_param
    "#{login}"
  end
  
  protected

  # From devise
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

end
