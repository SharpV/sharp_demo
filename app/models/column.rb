#encoding: utf-8

class Column < ActiveRecord::Base
  # attr_accessible :title, :body
  default_scope  { order('position ASC') }

  has_many :posts
  has_many :media

  class << self
    def random
      Column.offset(rand(Column.count)).first
    end
  end
end
