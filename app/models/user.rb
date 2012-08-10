#encoding: utf-8

require 'digest/sha1'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar,  ImageUploader

  has_many :note_categories
  has_many :documents
  has_many :groups
  has_many :posts
  has_many :topics, :class_name => 'Group::Topic'
  has_many :tasks, :class_name => 'Group::Task'
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, 
    :province_code, :city_code, :name, :field_id
  
  # Validations
  validates_presence_of :password
  validates_presence_of :email, :presence => true, :uniqueness => true
  validates_presence_of :password, :presence => true, :length => {:within => 6..50}
  validates :login, :presence => true, :length => {:within => 5..50}, :uniqueness => true, 
    :format => {:with => /\A\w+\z/, :message => '只允许数字、大小写字母和下划线'}
    
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

  private

  def email_must_be_uniq
    user = User.find_by_email(email)
    if user.present? && user.id =! self.id
      errors.add(:email, "is already taken")
    end
  end

  class << self
    %w( email slug name ).each do |a|
      eval <<-EOS
      def find_by_#{ a }(#{ a })             # def find_by_email(email)
        find :first,                         #   find(:first,
        :include => :actor,             #         :include => :actor,
        :conditions =>                  #         :conditions =>
        { 'actors.#{ a }' => #{ a } } #           { 'actors.email' => email }
      end                                    # end
      EOS
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
