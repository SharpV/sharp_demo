class Product < ActiveRecord::Base
  #attr_accessible :recommended_items, :coordinating_items
  belongs_to :category
  has_many :reviews

  serialize :recommended_items, JSON
  serialize :coordinating_items, JSON
  serialize :related_items, JSON

  def catelog
    category.parent.parent.name + "/" +  category.parent.name + "/" + category.name
  end
end
