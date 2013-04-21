class Assignment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :webclass
  belongs_to :course
  belongs_to :term
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'

  validates :title, :body, :course_id, :presence => true

end
