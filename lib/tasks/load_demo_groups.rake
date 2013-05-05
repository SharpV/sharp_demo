#encoding: utf-8 
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

SERVER = 'http://all.wasu.cn'

namespace :demo do
  namespace :groups do
    task :load => :environment do
      load_demo_groups
    end

    task :reset => :environment do
      Group.delete_all
    end
    
    def load_demo_groups
      puts "load demo groups......"
      index = "http://www.douban.com/group/search?start=1300&cat=1019&q=%E6%95%99%E8%82%B2"
      open_link(index).css('.paginator a').each do |link|
        index_page = open_link(link[:href])
        begin
          puts "load page #{link[:href]}"
          index_page.css('.groups .result').reverse.each do |div|
            group_link = div.at('.pic a')
            if group_link
            
              group_page = open_link(group_link['href'])
              title = group_page.at('#group-info h1').content

              body = group_page.at('.group-intro').content

              avatar = group_page.at('#group-info img').attributes['src'].value


              username = group_page.at('.group-board p a').content          

              uuid = UUID.new
              user = User.where(nickname: username).first_or_create(password: '12345678', password_confirmation: '12345678', 
                role: 'student', email: "#{uuid.generate}@haobanji.com")

              puts "create group user #{user.name} #{user.email}"

              grade = Grade.random

              subject = grade.random_subject

              group = Group.new name: title.strip, body: body, remote_avatar_url: avatar, readings_count: rand(100000)

              group.creator = user

              if group.save

                puts "create group #{group.name}"

                group_page.css('#group-topics .olt tr').each do |tr|  
                  puts tr.css('td').first.content
                  topic_link = tr.css('td').first.at('a')
                  if topic_link

                    topic_page = open_link topic_link[:href]
                    post = Post.new postable: group, creator: User.random, title: topic_page.at('#content h1').content.strip,
                      body: topic_page.at('.topic-content p').content
                    if post.save
                      puts "create group post #{post.title}"
                    end
                  end
                end
              end

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
