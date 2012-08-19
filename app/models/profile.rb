class Profile < ActiveRecord::Base
    
  accepts_nested_attributes_for :actor
  
  validates_presence_of :actor_id
  
  validates_format_of :mobile, :phone, :fax,
                      :allow_nil  => true,
                      :with       => /(^$)|(((\((\+?)\d+\))?|(\+\d+)?)[ ]*-?(\d+[ ]*\-?[ ]*\d*)+$)/,
                      :message    => "has a invalid format"
  
end
