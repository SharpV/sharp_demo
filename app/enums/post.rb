class Post < ClassyEnum::Base
end

class Post::Note < Post
end

class Post::Video < Post
end

class Post::Bookmark < Post
end
