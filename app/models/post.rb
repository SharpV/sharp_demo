require 'pathname'
require 'carrierwave/orm/activerecord'

class Post < ActiveRecord::Base
  mount_uploader :file, FileUploader 
  
  include Likeable
  
  acts_as_taggable_on :tags
  acts_as_commentable
  
  after_save :update_tag_list

  belongs_to :user
  belongs_to :group
  
  has_many :post_images


  before_validation :generate_slug
  #after_save :conv_to_swf
  
  validates :title, :presence => true, :length => {:within => 1..100}
  validates   :body, :presence => true
  
  
  #attr_accessor :minor_edit, :title, :body, :slug, :domain_id
  
  TYPES = {:article => 'article', :link => 'link', :pic => 'pic', :doc => 'doc', :question => 'question', 
    :audio => 'audio', :video => 'video'}
  
  scope :by_type, lambda { |type| where("kind = ?", type) }
  
  def avatar
    case kind
    when TYPES[:article] then "icon-edit"
    when TYPES[:pic] then "icon-picture"
    when TYPES[:link] then "icon-link"
    when TYPES[:doc] then "icon-file"
    when TYPES[:audio] then "icon-volume-up"
    when TYPES[:video] then "icon-camera"
    else "icon-flag"
    end
  end
  
  
  def conv_to_swf
    system " unoconv -f pdf #{file_path}"
    system "pdf2swf #{pdf_path} -o #{swf_path} -T 9 -f"
  end

  def file_extname
    File.extname(self.file.current_path)
  end

  def swf_path
    file.current_path.gsub("#{file_extname}", ".swf")
  end

  def pdf_path
    file.current_path.gsub("#{file_extname}", ".pdf")
  end

  def swf_url
    file.url.gsub("#{file_extname}", ".swf")
  end

  def pdf_url
    file.url.gsub("#{file_extname}", ".pdf")
  end


  def type
    self.kind || "article"
  end

  def to_param
    "#{id}-#{link.parameterize}"
  end

  def login
    user.login
  end

  def update_tag_list
    if !self.tag_list.empty? and domain
      domain.set_tag_list_on(:post_tag, self.tag_list.join(","))
      domain.save
      user.update_attribute :tag_list, self.tag_list.join(",")
    end
    
  end

  class << self
    def build_for_preview(params)
      post = Post.new(params)
      post.generate_slug
      post.set_dates
      post.apply_filter
      TagList.from(params[:tag_list]).each do |tag|
        post.tags << Tag.new(:name => tag)
      end
      post
    end

    def find_recent(options = {})
      tag = options.delete(:tag)
      options = {
        :order      => 'posts.published_at DESC',
        :conditions => ['published_at < ?', Time.zone.now],
        :limit      => DEFAULT_LIMIT
      }.merge(options)
      if tag
        find_tagged_with(tag, options)
      else
        find(:all, options)
      end
    end


    def find_all_grouped_by_month
      posts = find(
        :all,
        :order      => 'posts.published_at DESC',
        :conditions => ['published_at < ?', Time.now]
      )
      month = Struct.new(:date, :posts)
      posts.group_by(&:month).inject([]) {|a, v| a << month.new(v[0], v[1])}
    end
  end

  def generate_link
    if self.kind == TYPES[:link]
      begin
        l = Linkser.parse self.link, {:max_images => 1}
        puts link.inspect
        if l.is_a? Linkser::Objects::HTML
          puts l.inspect
          puts l.title
          self.body = l.description
          self.image = l.images.first
          self.title = l.title
        end
        return true
      rescue
       return false
      end
    else
      return true
    end
  end

  def denormalize_comments_count!
    Post.update_all(["approved_comments_count = ?", self.approved_comments.count], ["id = ?", self.id])
  end

  def generate_slug
    self.link = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
