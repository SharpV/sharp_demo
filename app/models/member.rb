#encoding: utf-8

class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :memberable, :polymorphic => true


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
  
end
