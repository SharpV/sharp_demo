class ZipImage < ActiveRecord::Base
  include Paperclip::Glue
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
