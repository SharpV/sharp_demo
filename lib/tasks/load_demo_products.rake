#encoding: utf-8 
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

namespace :demo do
  namespace :products do
    task :load => :environment do
      load_demo_product
    end

    task :reset => :environment do
      Product.delete_all
      Category.delete_all
    end
    
    def open_link(link)
      puts "open link #{link}..."
      Nokogiri::HTML(open(link))
    end
  end
end
