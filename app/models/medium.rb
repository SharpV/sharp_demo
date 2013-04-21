
class Medium < ActiveRecord::Base

  default_scope where("mediumable_id is not null and mediumable_type is not null")

  include Rails.application.routes.url_helpers
  # attr_accessible :title, :body
  belongs_to :creator, class_name: 'User'

  belongs_to :mediumable, :polymorphic => true

  mount_uploader :file, FileUploader

  before_save :update_file_attributes


  def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "thumbnail_url" => thumbnail_url,
      "delete_url" => medium_path(:id => id),
      "delete_type" => "DELETE"
    }
  end

  def thumbnail_url
    mime_icons_folder = "/assets/file-icons/48px"
    if !content_type
      ""
    elsif content_type.include? 'word'
      "#{mime_icons_folder}/doc.png"
    elsif content_type.include? 'pdf'
      "#{mime_icons_folder}/pdf.png"
    elsif content_type.include? 'excel'
      "#{mime_icons_folder}/xls.png"
    elsif content_type.include? 'vnd'
      "#{mime_icons_folder}/otp.png"
    elsif content_type.include? 'rar'
      "#{mime_icons_folder}/rar.png"
    end
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
