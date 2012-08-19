class Profile < ActiveRecord::Base
    
  validates_format_of :mobile, :phone, :fax,
                      :allow_nil  => true,
                      :with       => /(^$)|(((\((\+?)\d+\))?|(\+\d+)?)[ ]*-?(\d+[ ]*\-?[ ]*\d*)+$)/,
                      :message    => "has a invalid format"
  
end
