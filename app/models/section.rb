class Section < ActiveRecord::Base
  belongs_to :course, counter_cache: true  
  has_many :slots, order: :position

  acts_as_list scope: :course

end
