class Post::Note < Post
  
  acts_as_taggable_on :tags
  acts_as_commentable
  
  after_save :update_tag_list


  #after_save :conv_to_swf
  
  validates :title, :presence => true, :length => {:within => 1..30}
  validates :body, :presence => true
  validates :postable_id, :presence => true
  validates :postable_type, :presence => true

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
  
  

  def type
    self.kind || "article"
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

  def denormalize_comments_count!
    Post.update_all(["approved_comments_count = ?", self.approved_comments.count], ["id = ?", self.id])
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
  end

end
