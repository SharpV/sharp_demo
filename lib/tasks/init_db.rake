require 'rubygems'
require 'rake'
require 'date'
require 'rake/testtask'
require 'sequel'

$LOAD_PATH << File.join(File.dirname(__FILE__), './', 'lib')

namespace :db do
  task :init => :environment do
    Province.delete_all
    City.delete_all
    Zone.delete_all
    Sequel.connect("sqlite://#{Rails.root.to_s}/db/zones.db") do |db|
      db[:T_Province].each do |p|
        puts "create province #{p[:ProName]}"
        Province.create :name => p[:ProName], :code => p[:ProSort], :mark => p[:ProRemark]
      end
      db[:T_City].each do |c|
        puts "create city #{c[:CityName]}"
        City.create :name => c[:CityName], :province_code => c[:ProID], :code => c[:CitySort]
      end
      db[:T_Zone].each do |z|
        puts "create zone #{z[:ZoneName]}"
        Zone.create :name => z[:ZoneName], :code => z[:ZoneID], :city_code => z[:CityID]
      end
    end
  end
end
