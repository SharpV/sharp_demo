class Term < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :webclass
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'

end
