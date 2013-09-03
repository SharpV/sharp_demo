class ProductImage < ActiveRecord::Base
  # attr_accessible :title, :body
  mount_uploader :file, ImageUploader 

  belongs_to :product

end
