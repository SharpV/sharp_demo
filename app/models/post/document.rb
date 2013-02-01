class Post::Document < Post
	
  def conv_to_swf
    system " unoconv -f pdf #{file_path}"
    system "pdf2swf #{pdf_path} -o #{swf_path} -T 9 -f"
  end

  def file_extname
    File.extname(self.file.current_path)
  end

  def swf_path
    file.current_path.gsub("#{file_extname}", ".swf")
  end

  def pdf_path
    file.current_path.gsub("#{file_extname}", ".pdf")
  end

  def swf_url
    file.url.gsub("#{file_extname}", ".swf")
  end

  def pdf_url
    file.url.gsub("#{file_extname}", ".pdf")
  end

end