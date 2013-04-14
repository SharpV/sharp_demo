#encoding: utf-8
=begin
  
rescue Exception => e
  
end
Grade.delete_all
Subject.delete_all
Settings.grades.to_hash.each do |key, value|
  puts 'load grades ...'
  g = Grade.create :name => key
  value.each do |name|
    Grade.create :name => name, :parent => g
  end
end

Settings.subjects.to_hash.each do |key, value|
  puts 'load subjects ...'
  grade = Grade.find_by_name key
  grade.children.each do |g|
    value.each do |name|
      Subject.create :name =>name, :grade => g
    end
  end
end

=end