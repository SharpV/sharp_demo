require 'pathname'
require 'carrierwave/orm/activerecord'
class Asset < ActiveRecord::Base
	
	include Rails.application.routes.url_helpers

	mount_uploader :file, FileUploader 

  # attr_accessible :title, :body
	belongs_to :assetable, :polymorphic => true


	def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "thumbnail_url" => file.url,
      "delete_url" => asset_path(:id => id),
      "delete_type" => "DELETE"
    }
  end
end
