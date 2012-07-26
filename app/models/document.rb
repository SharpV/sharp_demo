require 'pathname'
require 'carrierwave/orm/activerecord'

class Document < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :user
  belongs_to :group

  #after_save :conv_to_swf

  def conv_to_swf
    system " unoconv -f pdf #{file_path}"
    system "pdf2swf #{pdf_path} -o #{swf_path} -T 9 -f"
  end

  def file_path
    file.current_path
  end

  def dir_path
    File.dirname(self.file.current_path)
  end

  def file_without_extname
    File.basename(self.file.current_path, File.extname(self.file.current_path))
  end

  def swf_path
    "#{dir_path}/#{file_without_extname}.swf"
  end

  def pdf_path
    "#{dir_path}/#{file_without_extname}.pdf"
  end
  
end