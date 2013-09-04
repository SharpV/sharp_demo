#encoding: utf-8

require 'digest/sha1'
require 'uuid'
require 'devise/orm/active_record'
require 'open-uri'

class User < ActiveRecord::Base

  paginates_per 20
  
  has_many :follows, as: :actor
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :description, :nickname
  
  
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
end
