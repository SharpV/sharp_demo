
class ProductImage < ActiveRecord::Base
  #attr_accessor :file
  include Paperclip::Glue
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  belongs_to :product

end
