class Image < ActiveRecord::Base

  mount_uploader :file, ImageUploader 

  belongs_to :creator, class_name: 'User'

  belongs_to :imageable, :polymorphic => true


  def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "thumbnail_url" => file_url(:s),
      "delete_url" => medium_path(:id => id),
      "delete_type" => "DELETE"
    }
  end
end
