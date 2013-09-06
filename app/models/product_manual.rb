class ProductManual < ActiveRecord::Base
  # attr_accessible :title, :body
  include Paperclip::Glue
  has_attached_file :file
  has_attached_file :cover
end
