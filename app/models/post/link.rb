class Post::Link < Post
  validates :title, :presence => true, :length => {:within => 1..100}

  validates :url, :presence => true, :length => {:within => 1..200}

  validates :kind, :presence => true
  validates :user_id, :presence => true
  
  scope :list, where(:kind => 'bookmark')
end