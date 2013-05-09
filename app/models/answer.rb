#encoding: utf-8

class Answer < ActiveRecord::Base
  make_voteable

  default_scope  where('question_id is not null')

  belongs_to :user, counter_cache: true
  belongs_to :question, counter_cache: true
end
