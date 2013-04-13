class Course < ActiveRecord::Base

  default_scope where("webclass_id is not null and term_id is not null")

	validates :name, :presence => true, :length => {:within => 1..30}
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'
  has_many :slots
  has_many :sections, order: :start_at, :through => :slots

  belongs_to :term


  def member(user)
    CoursesMember.where(user_id: user.id, course_id: self.id).first
  end

end
