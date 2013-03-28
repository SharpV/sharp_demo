class Bookmark < ActiveRecord::Base
  belongs_to :user

  validates :title, :origin_url, :presence => true

end
