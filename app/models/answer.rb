class Answer < ActiveRecord::Base
  make_voteable
  belongs_to :user
  belongs_to :question, counter_cache: true
end
