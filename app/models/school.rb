#encoding: utf-8

class School < ActiveRecord::Base
  # attr_accessible :title, :body

  paginates_per 36

  belongs_to :province, counter_cache: true
  belongs_to :city, counter_cache: true
  belongs_to :zone, counter_cache: true

  mount_uploader :avatar, ImageUploader

end
