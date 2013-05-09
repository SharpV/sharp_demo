#encoding: utf-8

class Activity < ActiveRecord::Base

  belongs_to :trackable
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'

end
