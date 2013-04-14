#encoding: utf-8

require 'rubygems'
require 'rake'
require 'date'
require 'rake/testtask'
require 'uuid'

namespace :db do
  task :init_students => :seed do
    students
  end

  def students
    (1..100).to_a.each do |i|
      uuid = UUID.new
      s = User.new({:email => "#{uuid.generate}@haobanji.com", :password => "12345678", :password_confirmation => "12345678", nickname: "student#{i}" })
      puts s.save#.save(false)

      Webclass.all.each do |webclass|
        s.webclasses << webclass
        if s.save
          s.add_role :student, webclass
        end
      end
    end
  end

  def init_teacher
    (1..100).to_a.each do |i|
      t = User.new({:email => "#{uuid.generate}@haobanji.com", :password => "12345678", :password_confirmation => "12345678", nickname: "teacher#{i}" }).save(false)
    end
  end

  def init_parent
  end
end
