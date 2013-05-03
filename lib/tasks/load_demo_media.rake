#encoding: utf-8 
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

namespace :demo do
  namespace :media do
    task :load => :environment do
      load_demo_media
    end

    task :reset => :environment do
      Medium.delete_all
    end
    
    def load_demo_media
      puts "load demo posts......"
      index = "http://blog.ntjy.net/educations/teaching"
      (1..62).to_a.reverse.each do |page|
        index_page = open_link(index + "?page=" + page.to_s)
        begin
          puts "load page #{page}"
          index_page.css('.mix-list').first.css('tr').reverse.each do |tr|
            td_link = tr.css('td')[3]
            if media_link = td_link.at('a')
              username =tr.css('td')[4].content

              post_page = open_link("http://blog.ntjy.net"+media_link['href'])
            
              photo = post_page.at('#login .infobox .tablecc img').attributes['src'].value
           
              uuid = UUID.new
              user = User.where(nickname: username).first_or_create(password: '12345678', password_confirmation: '12345678', 
              role: 'teacher', email: "#{uuid.generate}@haobanji.com")

              puts "create user #{user.name} #{user.avatar_url}"

              user.generate_avatar("http://blog.ntjy.net#{photo}")

            else
              break
            end

            if download_link = post_page.at('#in_tablem .infobox .tablecc a')
              title = download_link.content
              grade = Grade.random

              subject = grade.random_subject

              medium = Medium.new title: title, readings_count: rand(10000), remote_file_url: "http://blog.ntjy.net"+download_link[:href]
              medium.creator = user
              medium.mediumable = user.folders.first

              medium.grade = grade
              medium.subject = subject

              medium.save

              puts "create medium #{medium.title} #{medium.file_url}"

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
