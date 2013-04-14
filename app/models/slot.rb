class Slot < ActiveRecord::Base
  attr_accessible :name, :section_id, :week, :term_id, :course_id
  validates :name, :course_id, :section_id,:presence => true

  belongs_to :section, dependent: :destroy
  belongs_to :course, dependent: :destroy
  belongs_to :term

  def name
    self.course.nil? ? nil : self.course.name
  end
end
