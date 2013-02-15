class Post < ActiveRecord::Base
  belongs_to :user
  def to_param
    "#{id}-#{url.parameterize}"
  end
end
