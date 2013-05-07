#encoding: utf-8 
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

SERVER = 'http://all.wasu.cn'

namespace :demo do
  namespace :posts do
    task :load => :environment do
      load_demo_posts
    end

    task :reset => :environment do
      Post.delete_all
    end
    
    def load_demo_posts
      puts "load demo posts......"
      index = "http://blog.ntjy.net/blogs"
      (1..175).to_a.reverse.each do |page|
        index_page = open_link(index + "?page=" + page.to_s)
        begin
          puts "load page #{page}"
          index_page.css('#in_tablem ul').reverse.each do |ul|
            post_link = ul.at('.nlst h3 a')
            username = ul.at('.ilst a img').attributes['alt'].value
            post_page = open_link("http://blog.ntjy.net"+post_link['href'])
            
            photo = post_page.at('#login .infobox .tablecc img').attributes['src'].value
           
            uuid = UUID.new
            user = User.where(nickname: username).first_or_create(password: '12345678', password_confirmation: '12345678', 
              role: 'teacher', email: "#{uuid.generate}@haobanji.com")

            puts "create user #{user.name} #{user.avatar_url}"

            user.remote_avatar_url = "http://blog.ntjy.net#{photo}"

            user.save

            category_name = post_page.css('#in_tablem div').first.content.split(' ')[1]
            puts "category is #{category_name}"

            category = Category.new name: category_name
            category.categoryable = user
            category.creator = user

            if category.save
              title = post_page.css('#main #table #in_tablem h2 span').last.content
              content = post_page.css('.infobox').first.at('.tablecc').content

              post = Post.new title: title, body: content, readings_count: rand(10000), created_at: rand(100000).hours.ago
              post.creator = user
              post.postable = category

              post.column = Column.random
              if post.save
                puts "create post #{post.title}"
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
