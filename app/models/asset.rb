require 'pathname'
require 'carrierwave/orm/activerecord'
class Asset < ActiveRecord::Base
	
	mount_uploader :file, FileUploader 

  # attr_accessible :title, :body
	belongs_to :assetable, :polymorphic => true


	def to_jq_upload
    {
      "name" => read_attribute(:avatar),
      "size" => avatar.size,
      "url" => avatar.url,
      "thumbnail_url" => avatar.thumb.url,
      "delete_url" => picture_path(:id => id),
      "delete_type" => "DELETE"
    }
  end
end
