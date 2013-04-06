class Section < ActiveRecord::Base
  belongs_to :course, counter_cache: true  
  has_many :slots, order: :position

  include TheSortableTree::Scopes

  validates :title, :presence => true, :length => {:within => 1..30}

end
