class Post::Bookmark < Post

  def generate_link
    if self.kind == TYPES[:link]
      begin
        l = Linkser.parse self.link, {:max_images => 1}
        puts link.inspect
        if l.is_a? Linkser::Objects::HTML
          puts l.inspect
          puts l.title
          self.body = l.description
          self.image = l.images.first
          self.title = l.title
        end
        return true
      rescue
       return false
      end
    else
      return true
    end
  end
end