#encoding: utf-8

require 'rubygems'
require 'rake'

$LOAD_PATH << File.join(File.dirname(__FILE__), './', 'lib')

namespace :db do
  namespace :grades do
    task :load => :environment do
      Grade.delete_all
      Subject.delete_all
      Settings.grades.to_hash.each do |key, value|
        puts 'load grades ...'
        g = Grade.create :name => key
        value.each_with_index do |name, index|
          Grade.create :name => name, :parent => g, position: index
          puts "load #{name}"
        end
      end
  
      Settings.subjects.to_hash.each do |key, value|
        puts 'load subjects ...'
        grade = Grade.find_by_name key
        grade.children.each do |g|
          value.each_with_index do |name, index|
            Subject.create :name => name, :grade => g, position: index
            puts "load #{name}"
          end
        end
      end
    end
  end
end
