module Crawler
  class Site
    def open_link(link)
      puts "open link #{link}..."
      Nokogiri::HTML(open(link))
    end
  end
end