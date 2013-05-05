#encoding: utf-8

require 'rubygems'
require 'rake'
require 'date'
require 'rake/testtask'
require 'uuid'

namespace :db do
  namespace :webclasses do
    task :load => :environment do
      load_webclasses
    end

    def load_webclasses
      index = "http://banji.tongyi.com/index/class_list/0/0/0/0/?sort=1&mode=0&per_page="
      page = 8530#8930
      while (page > 0)
        begin
          url = URI::encode "#{index}#{page}"
          page = page - 10
          index_page = open_link(url)
          #puts index_page.css('.area_list').first.inspect 
          index_page.css('#classes .each_result').each do |class_div|

            class_avatar = class_div.at('img.class_photo')['src']
            class_name = class_div.css('.class_mess a').first.content

            school_name = class_div.css('span').first.at('strong').content

            webclass = Group.new name: class_name, is_class: true, remote_avatar_url: class_avatar, readings_count: rand(100000),
                body: class_name, creator: User.random, created_at: rand(100000).hours.ago

            if school = School.where(name: school_name).first
              webclass.school = school
            else
              puts "can not find school #{school_name}"
            end

            if webclass.save
              if webclass.school 
                puts "create webclass #{webclass.school.name} #{webclass.name}"
              else
                puts "create webclass #{webclass.name}"
              end
              (1..8).to_a.each do |i|
                user = create_user('teacher')
                member = Member.new group_id: webclass.id, user_id: user.id, role: user.role, 
                  created_at: rand(100000).hours.ago
                member.save
              end

              (1..40).to_a.each do |i|
                user = create_user('student')
                member = Member.create group_id: webclass.id, user_id: user.id, role: user.role, 
                  created_at: rand(100000).hours.ago
                member.save
              end
            end
          end
        rescue Exception => e
          puts "----- #{e.inspect}"
        end
      end
    end

    def create_user(role)
      uuid = UUID.new
      User.create({:email => "#{uuid.generate}@haobanji.com", role: role, :password => "12345678", 
        :password_confirmation => "12345678", nickname: "#{role}-#{rand(1000)}" })
    end
  end
end
