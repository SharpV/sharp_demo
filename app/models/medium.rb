require 'pathname'
require 'carrierwave/orm/activerecord'
class Medium < ActiveRecord::Base

  include Rails.application.routes.url_helpers
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :folder

  mount_uploader :file, FileUploader 

  before_save :update_file_attributes


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
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
