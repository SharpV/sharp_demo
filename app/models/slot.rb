class Slot < ActiveRecord::Base
  belongs_to :course, counter_cache: true  
  belongs_to :section
  acts_as_list scope: :section

  mount_uploader :file, FileUploader 

  validates :title, :presence => true, :length => {:within => 1..30}

  has_many :media, dependent: :destroy, as: :mediumable

  belongs_to :creator,  :class_name => "User"

end
