#encoding: utf-8

require 'pathname'
require 'carrierwave/orm/activerecord'
class Asset < ActiveRecord::Base
	
	include Rails.application.routes.url_helpers

	mount_uploader :file, FileUploader 

  before_save :update_file_attributes


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


  private
  
  def update_file_attributes
    if file.present? && file_changed?
      self.file_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
