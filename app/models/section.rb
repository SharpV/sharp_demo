class Section < ActiveRecord::Base
  attr_accessible :title, :start_at, :end_at
  default_scope where("group_id is not null and term_id is not null")

  belongs_to :term
  belongs_to :group

  has_many :slots
  has_many :courses, :through => :slots

  validates :title, :uniqueness => {:scope => :group_id}
  validates :title, :presence => true, :length => {:within => 1..10}
  validates :start_at, presence: true

  belongs_to :creator,  :class_name => "User"

  def get_slot week
    Slot.where(section_id: id, week: week).first
  end

end
