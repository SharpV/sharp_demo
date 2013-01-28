class CreatePostVideos < ActiveRecord::Migration
  def change
    create_table :post_videos do |t|

      t.timestamps
    end
  end
end
