class Slot < ActiveRecord::Base
  belongs_to :course, counter_cache: true  
  belongs_to :section
  acts_as_list scope: :section
end
