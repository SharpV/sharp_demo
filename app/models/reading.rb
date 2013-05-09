#encoding: utf-8

class Reading < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :readable
end
