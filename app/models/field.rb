#encoding: utf-8
class Field < ActiveRecord::Base
  acts_as_nested_set
  acts_as_taggable_on :tags
  attr_accessible :name, :parent_id
  has_many :users

  #scope :excluding_ids, lambda { |ids| where(['id NOT IN (?)', ids]) if ids.any?}

end
