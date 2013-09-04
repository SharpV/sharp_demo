#!/usr/bin/env ruby

require 'active_record'
require 'logger'
require 'pg'
require 'optparse'
require 'pp'


RailsRoot = File.expand_path("../../../", __FILE__)
RailsEnv = ENV['RAILS_ENV'] || 'development'

ActiveRecord::Base.logger = Logger.new("#{RailsRoot}/log/crawler.log")
ActiveRecord::Base.configurations = YAML::load(IO.read("#{RailsRoot}/config/database.yml"))
ActiveRecord::Base.establish_connection(RailsEnv)

def run(site)
  pp site
end

if ['lowes.ca'].include? ARGV[0]
 run(ARGV[0].gsub(/\./, '_')) 
else
  pp "You need to pass valid params first"
end