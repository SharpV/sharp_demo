#encoding: utf-8

class Exam < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :webclass
  belongs_to :term
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User' 
  belongs_to :course 
  validates :title, :presence => true

end
