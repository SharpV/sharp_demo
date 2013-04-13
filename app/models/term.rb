 # encoding: utf-8

class Term < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :webclass
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'
  has_many :sections
  has_many :courses

  def name
    year.to_s + "年度" + part_name
  end

  def part_name
    part == 0 ? "上学期" : "下学期"
  end

  def get_course name
    options = {webclass_id: webclass_id, term_id: id, name: name}
    course =  Course.where(options).first_or_create options.merge(creator_id: creator_id) 
  end
end
