class Product < ActiveRecord::Base
  #attr_accessible :recommended_items, :coordinating_items
  belongs_to :category
  has_many :reviews

  serialize :recommended_items, JSON
  serialize :coordinating_items, JSON
  serialize :additional_info, JSON

  has_many :product_images

  has_many :product_manuals

  def catelog
    category.parent.parent.name + "/" +  category.parent.name + "/" + category.name
  end
end
