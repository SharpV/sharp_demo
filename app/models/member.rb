#encoding: utf-8

class Member < ActiveRecord::Base

  include Role 
  
  belongs_to :user
  belongs_to :group, counter_cache: true
  
  scope :apply, where(:active => false)
  scope :active, where(:active => true)
  scope :teacher, where(:role => 'teacher')


  def name
    user.nickname
  end

  def role_name
    case role
    when 'teacher' then '老师'
    when 'student' then '学生'
    when 'parent' then '家长'
    end   
  end

  def admin?
    admin || webclass.creator_id == self.user_id
  end
  
end
