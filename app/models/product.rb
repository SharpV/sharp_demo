class Product < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :category

  def catelog
    category.parent.parent.name + "/" +  category.parent.name + "/" + category.name
  end
end
