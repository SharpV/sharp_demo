class Review < ActiveRecord::Base
  attr_accessible :title, :body, :author, :city, :created_at, :star
  belongs_to :product

end
