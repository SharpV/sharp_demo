#encoding: utf-8

require 'digest/sha1'

require 'devise/orm/active_record'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  has_many :connects, dependent: :destroy
  has_many :groups_members, dependent: :destroy


  has_many :groups, through: :groups_members
  has_one :group
  has_many :courses
  has_many :posts, as: :postable
  has_many :post_categories
  has_many :media
  has_many :folders

  has_many :adminable_groups,
           :through => :admin_memberships,
           :class_name => 'Group',
           :source => :group
  has_many :group_requests,
           :through => :membership_requests,
           :class_name => 'Group',
           :source => :group
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :login, :remember_me, :profile_attributes, :nickname

  validates_presence_of :email

  validates_format_of :email, with: Devise.email_regexp, allow_blank: true

  validate :email_must_be_uniq

  before_validation :generate_login

  mount_uploader :avatar,  ImageUploader

  with_options :if => :password_required? do |v|
    v.validates_presence_of     :password
    v.validates_confirmation_of :password
    v.validates_length_of       :password, within: Devise.password_length, :allow_blank => true
  end

  def folders
    user_folders = Folder.where user_id: self.id
    if user_folders.blank?
      user_folders << Folder.create!(name: "默认目录", user_id: self.id)
    end
    user_folders
  end

  def post_categories
    user_categories = PostCategory.where user_id: self.id
    if user_categories.blank?
      user_categories << PostCategory.create!(name: "默认目录", user_id: self.id)
    end
    user_categories
  end
  
  def flow
    #tag_ids = subscriptions.select(:tag_id).to_sql
    user_ids = friends.select(:followed_user_id).to_sql
    conditions = []
    conditions << "posts.user_id = #{id}"
    #conditions << "taggings.tag_id in (#{tag_ids}) and posts.is_private = 'f'"
    conditions << "posts.user_id in (#{user_ids}) and posts.is_private = 'f'"
    Post.joins(:comments).where(conditions.join(' or ')).uniq
  end
    
  def to_param
    "#{login}"
  end

  def generate_login
    self.login = Digest::SHA1.hexdigest("#{email}#{Time.now}") unless self.login
  end

  protected
  
  # From devise
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  private

  def email_must_be_uniq
    user = User.find_by_email(email)
    if user.present? && user.id =! self.id
      errors.add(:email, "is already taken")
    end
  end
  
  class << self

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
