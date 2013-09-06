class Product < ActiveRecord::Base
  #attr_accessible :recommended_items, :coordinating_items
  belongs_to :category
  has_many :reviews

  serialize :recommended_items, Array
  serialize :coordinating_items, Array
  serialize :additional_info, Array

  has_many :product_images
  has_many :product_manuals

  def catelog
    category.parent.parent.name + "/" +  category.parent.name + "/" + category.name
  end
end
