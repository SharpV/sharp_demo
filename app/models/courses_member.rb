class CoursesMember < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :course
end
