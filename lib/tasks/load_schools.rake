#encoding: utf-8 

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

namespace :db do
  namespace :schools do
    task :load => :environment do
      load_schools
    end

    task :reset => :environment do
      School.delete_all
    end
    
    def load_schools
      Province.delete_all
      City.delete_all
      Zone.delete_all
      School.delete_all
      index = "http://banji.tongyi.com/index/school/0/0/0/0/?sort=1&mode=0&per_page="
      page = 677630
      while (page > 0)
        begin
          url = URI::encode "#{index}#{page}"
          page = page - 10
          index_page = open_link(url)
          #puts index_page.css('.area_list').first.inspect 
          index_page.css('#school .each_result').each do |school_div|

            school_avatar = school_div.at('.class_photo img')['src']
            school_name = school_div.at('.class_mess a span')['title']

            area = school_div.css('strong')[1].content

            province_name = area.split(' ')[0]
            city_name = area.split(' ')[1]
            zone_name = area.split(' ')[2]
            province = Province.where(name: province_name).first_or_create
            city = City.where(name: city_name).first_or_create(province_id: province.id)
            zone = Zone.where(name: zone_name).first_or_create(city_id: city.id)
            
            school = School.new name: school_name, province: province, city: city, zone: zone, created_at: rand(1000000).hours.ago
            school.remote_avatar_url = school_avatar
            if school.save
              puts "create school #{province.name} #{city.name} #{zone.name} #{school.name} #{school.avatar_url}"
            end
          end
        rescue Exception => e
          puts "----- #{e.inspect}"
        end
      end
    end
    
    def open_link(link)
      puts "open link #{link}..."
      Nokogiri::HTML(open(link))
    end
  end
end
