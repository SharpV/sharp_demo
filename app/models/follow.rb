class Follow < SharpSocial::Models::Follow

  belongs_to :actor, polymorphic: true
  belongs_to :follower, polymorphic: true

  def block!
    self.update_attribute(:blocked, true)
  end

end