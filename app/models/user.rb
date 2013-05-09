#encoding: utf-8

require 'digest/sha1'
require 'uuid'
require 'devise/orm/active_record'
require 'open-uri'

class User < ActiveRecord::Base

  include Role
  
  acts_as_actor
  make_voter
  has_many :follows, as: :actor
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :description, :nickname
  
  has_many :activities, as: :creator
  has_many :readings
  has_many :albums
  has_many :questions
  has_many :answers
  has_many :members
  has_many :groups, through: :members
  has_many :exams, as: :creator
  has_many :courses, through: :courses_members
  has_many :images
  has_many :messages, as: :sender
  has_many :messages, as: :recipient
  has_many :posts
  has_many :media
  has_many :categories
  has_many :folders
  has_many :comments
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :login, :remember_me, :avatar, :nickname, :role

  validates_presence_of :email, :nickname

  validates_format_of :email, with: Devise.email_regexp, allow_blank: true

  validate :email_must_be_uniq

  after_create :create_default_category_and_folder
  before_validation :generate_login


  mount_uploader :avatar,  ImageUploader

  with_options :if => :password_required? do |v|
    v.validates_presence_of     :password
    v.validates_confirmation_of :password
    v.validates_length_of       :password, within: Devise.password_length, :allow_blank => true
  end

  def is_admin_member? (memberable)
    member = member(memberable) 
    if member
      webclass.creator_id == self.id || memberable.admin
    end
  end

  def own_courses
    Course.where creator_id: self.id
  end

  def own_groups
    Group.where creator_id: self.id
  end

  def member(group)
    Member.where(group_id: group.id, user_id: self.id).first
  end
  
  def read(record)
    reading = Reading.where(user_id: id, readable_id: record.id, readable_type: record.class.name).first 
    if reading and reading.created_at < 1.hours.ago
      record.update_attributes(readings_count: record.readings_count+1)
      reading.update_attributes(read_at: Time.now, created_at: Time.now)
    elsif reading
      reading.update_attributes read_at: Time.now
    else
      record.update_attributes(readings_count: record.readings_count+1)
      Reading.create(user_id: id, readable_id: record.id, readable_type: record.class.name, read_at: Time.now) 
    end
  end
    
  def to_param
    "#{id}"
  end

  alias_attribute :name, :nickname

  def generate_avatar(image)
    uploader = ImageUploader.new
    path = "#{Rails.root.to_s}/public/tmp/#{login.to_s}.#{image.split('.').last}"

    open(URI::encode(image)) do |f|
      File.open(path, "wb") do |file|
        file.puts f.read
      end      
      self.avatar = File.open path
      self.save         
    end
    
  end

  protected
  
  # From devise
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  private

  def generate_login
    unless self.login 
      uuid = UUID.new
      self.login = uuid.generate 
    end
  end

  def create_default_category_and_folder
    folder = self.folders.build name: '默认目录'
    category = self.categories.build name: '默认分类'
    folder.save and category.save
  end

  def email_must_be_uniq
    user = User.find_by_email(email)
    if user.present? && user.id =! self.id
      errors.add(:email, "is already taken")
    end
  end
  
  class << self

    def random
      User.offset(rand(User.count)).first
    end
   # Overwrite devise default find method to support login with email,
    # presence ID and login
    def find_for_authentication(conditions)
      if ( login = conditions[:email] ).present?
        if login =~ /@/
          find_by_email(login)
        else
          find_by_slug(login)
        end
      else
        super
      end
    end

    def find_or_create_for_facebook_oauth(hash, signed_in_resource = nil)
      puts hash.inspect
      auth = Authentication.find_by_provider_and_uid(hash["provider"], hash["uid"])
      user = User.find_by_email(hash["info"]["email"])

      if user.nil?
        user = User.create!(:name => hash["info"]["name"], :email => hash["info"]["email"], :password => Devise.friendly_token[0,20])
      end

      if auth.nil?
        auth = Authentication.create!(:user_id => user.id, :uid =>hash["uid"], :provider => hash["provider"])
      end

      user
    end
    
    def find_or_create_for_linkedin_oauth(hash,signed_in_resource=nil)
      auth = Authentication.find_by_uid_and_provider(hash["uid"],hash["provider"])
      if auth==nil
        user = User.create!(:name => hash["info"]["name"], :email => 'demo@socialstream.com', :password => Devise.friendly_token[0,20])
        auth = Authentication.create!(:user_id => user.id, :uid =>hash["uid"], :provider => hash["provider"])
        user
      else
        user = User.find_by_id(auth.user_id)
        user
      end
    end
    
  end
end
