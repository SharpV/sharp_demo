class GroupTopic < ActiveRecord::Base

  attr_accessible :title, :category_id, :body

  belongs_to :group
  belongs_to :user
  belongs_to :category

end
