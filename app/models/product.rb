class Product < ActiveRecord::Base
  #attr_accessible :recommended_items, :coordinating_items
  belongs_to :category
  has_many :reviews

  serialize :recommended_items, Array
  serialize :coordinating_items, Array
  serialize :additional_info, Array

  has_many :product_images
  has_many :product_manuals


  scope :display, where("category_id is not null")

  def catelog
    str = ""
    return str unless category
    if category.parent and category.parent.parent
      str += category.parent.parent.name + "/" 
    end
    if category.parent  
      str +=  category.parent.name + "/" + category.name
    end
  end
end
