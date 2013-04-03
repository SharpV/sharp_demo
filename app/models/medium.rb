
class Medium < ActiveRecord::Base

  default_scope where("mediumable_id is not null and mediumable_type is not null and folder_id is not null")

  include Rails.application.routes.url_helpers
  # attr_accessible :title, :body
  belongs_to :folder

  belongs_to :creator, class_name: 'User'

  belongs_to :mediumable, :polymorphic => true

  mount_uploader :file, FileUploader 

  before_save :update_file_attributes


  def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "thumbnail_url" => thumbnail_url(:s),
      "delete_url" => me_medium_path(:id => id),
      "delete_type" => "DELETE"
    }
  end

  def thumbnail_url(mode='s')
    if content_type.include? 'image'
      #file_url(mode)
    elsif content_type.include? 'pdf'
      #'/assets/media/pdf.gif'
    end
    file_url
  end


  private
  
  def update_file_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
