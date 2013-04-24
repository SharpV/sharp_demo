#encoding: utf-8

require 'rubygems'
require 'rake'
require 'date'
require 'rake/testtask'
require 'uuid'

namespace :demo do
  task :init_webclass_members => :environment do
    create_webclass_members
  end

  def create_webclass_members
    Member.delete_all memberable_type: Webclass.to_s
    (1..50).to_a.each do |i|
      s = create_user('student')
      p1 = create_user('parent')
      p2 = create_user('parent')
      t = create_user('teacher')
      puts "create #{s.nickname} #{p1.nickname} #{p2.nickname} #{t.nickname}"
      Webclass.all.each do |webclass|
        member = Member.create user_id: s.id, memberable_type: Webclass.to_s, memberable_id: webclass.id, 
          role: 'student', active: true
        
        Member.create user_id: p2.id, memberable_type: Webclass.to_s, memberable_id: webclass.id, 
          student_id: member.id, role: 'parent', active: true
        Member.create user_id: p2.id, memberable_type: Webclass.to_s, memberable_id: webclass.id, 
          student_id: member.id, role: 'parent', active: true
        if webclass.teachers.count < 10
          Member.create user_id: s.id, memberable_type: Webclass.to_s, memberable_id: webclass.id, 
          role: 'teacher', active: true
        end
      end
    end
  end

  def create_user(role)
    uuid = UUID.new
    User.create({:email => "#{uuid.generate}@haobanji.com", role: role, :password => "12345678", :password_confirmation => "12345678", nickname: "#{role}-#{rand(1000)}" })
  end

end
