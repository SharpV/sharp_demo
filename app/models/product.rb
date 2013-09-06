class Product < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :category

  serialize :recommended_items, Array
  serialize :coordinating_items, Array
  serialize :related_items, Array

  has_many :product_images
  has_many :product_manuals

  def catelog
    category.parent.parent.name + "/" +  category.parent.name + "/" + category.name
  end
end
