#encoding: utf-8

class Grade < ActiveRecord::Base
  default_scope order("parent_id, position")

  scope :child_grade, where("parent_id is not null")
  scope :parent_grade, where("parent_id is null")
  acts_as_nested_set
  
  attr_accessible :name, :parent_id, :parent
  attr_protected :lft, :rgt
  
  has_many :subjects
  has_many :media, as: :mediumable
  has_many :posts, as: :postable
  has_many :questions

  def random_subject
    subjects.offset(rand(subjects.count)).first
  end

  class << self
    def random
      Grade.child_grade.offset(rand(Grade.child_grade.count)).first
    end
  end
end