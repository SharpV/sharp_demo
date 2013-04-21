class Image < ActiveRecord::Base

  include Rails.application.routes.url_helpers
  mount_uploader :file, ImageUploader 

  belongs_to :creator, class_name: 'User'

  belongs_to :imageable, :polymorphic => true

  before_save :update_file_attributes


  def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "thumbnail_url" => file_url(:s),
      "delete_url" => image_path(:id => id),
      "delete_type" => "DELETE"
    }
  end

  private
  
  def update_file_attributes
    if file.present? && file_changed? 
      self.content_type = file.file.content_type
      self.file_size = file.file.size
      self.file_name = read_attribute(:file)
    end
  end
end
