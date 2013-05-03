#encoding: utf-8 
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

SERVER = 'http://all.wasu.cn'

namespace :demo do
  namespace :questions do
    task :load => :environment do
      load_demo_questions
    end

    task :reset => :environment do
      Question.delete_all
    end
    
    def load_demo_questions
      puts "load demo questions......"
      index = "http://114.tongyi.com"
      (1..1000).to_a.reverse.each do |page|
        index_page = open_link(index + "/browse-page-#{page}.html")
        begin
          puts "load page #{page}"
          index_page.css('#owninfo .border_t tr').reverse.each do |tr|
            question_link = tr.at('td a')
            if question_link
            
              question_page = open_link("http://114.tongyi.com/"+question_link['href'])
              title = question_page.at('#question h1').content

              body = question_page.at('#question p.q_detail').content

              username = question_page.css('#question .q_mess').last.content.split(':')[1].split(" ").first            

              uuid = UUID.new
              user = User.where(nickname: username).first_or_create(password: '12345678', password_confirmation: '12345678', 
                role: 'student', email: "#{uuid.generate}@haobanji.com")

              puts "create question user #{user.name} #{user.email}"

              grade = Grade.random

              subject = grade.random_subject


              question = Question.new user: user, title: title, body: body, subject: subject, grade: grade, 
                readings_count: rand(10000)

            
              if question.save

                puts "create question #{question.title}"

                question_page.css('.answer').each do |answer|  
                  answer_body = answer.at('p.ans').content
                  answer = Answer.new body: answer_body, user: User.random, question: question
                  if answer.save
                    puts "create answer"
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
