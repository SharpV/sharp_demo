module Crawler
  class Site
    IntervalTime = 1
    def open_link(link)
      puts "open link #{link}..."
      Nokogiri::HTML(open(link))
    end
  end
end