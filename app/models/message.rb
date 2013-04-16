class Message < ActiveRecord::Base
  #attr_accessible :recipient_id
  validates :title, :body, :recipient_id, :presence => true

  belongs_to :webclass
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  scope :webclass, where('webclass_id is not null and recipient_id is not null and sender_id is not null')


  def replies
    Message.where parent_id: id
  end
end
