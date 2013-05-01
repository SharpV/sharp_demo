class Column < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_list 
  has_many :children, order: :position
end
