#encoding: utf-8

class Consume < ActiveRecord::Base
  belongs_to :user

  #scope :excluding_ids, lambda { |ids| where(['id NOT IN (?)', ids]) if ids.any?}

end
