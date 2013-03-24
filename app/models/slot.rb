class Slot < ActiveRecord::Base
  belongs_to :course, counter_cache: true  
end
