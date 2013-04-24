# Migration responsible for creating a table with activities
class CreateSharpSocial < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :activities do |t|
      t.references :actor, :polymorphic => true, :null => false
      t.text :content
      t.timestamps
    end

    add_index :activities, [:actor_id, :actor_type]

    create_table :follows, :force => true do |t|
      t.references :actor, :polymorphic => true, :null => false
      t.references :follower, :polymorphic => true, :null => false
      t.boolean :blocked, :default => false, :null => false
      t.timestamps
    end

    add_index :follows, ["actor_id", "actor_type"]
    add_index :follows, ["follower_id", "follower_type"]
  end

  def self.down
    drop_table :activities
    drop_table :follows
  end
end
