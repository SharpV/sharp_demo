class Bookmark < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :origin_url

end
