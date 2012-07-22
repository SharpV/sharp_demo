require 'pathname'
require 'carrierwave/orm/activerecord'

class Group < ActiveRecord::Base

  mount_uploader :logo, ImageUploader
  
  belongs_to :user
  
  before_validation  :generate_permalink
  


  def profile!
    actor!.profile || actor!.build_profile
  end
 
  def recent_groups
    contact_subjects(:type => :group, :direction => :sent) do |q|
      q.select("contacts.created_at").
        merge(Contact.recent)
    end
  end

  private
  
  
  def generate_permalink
    self.permalink = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
