class Post < ActiveRecord::Base
	belongs_to :user

	KIND = {note: 1, bookmark: 2, video: 3}

end
