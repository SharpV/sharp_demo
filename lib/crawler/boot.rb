#!/usr/bin/env ruby


RailsRoot = File.expand_path("../../../", __FILE__)
RailsEnv = ARGV[1] || 'development'

require 'active_record'
require 'active_support'
require 'logger'
require 'pg'
require 'optparse'
require 'pp'
require 'require_all'
require File.expand_path('../gems', __FILE__)
require File.expand_path('../site', __FILE__)


require_rel 'sites/**/*.rb' 

CrawlerLogger = Logger.new("#{RailsRoot}/log/crawler.log")

ActiveRecord::Base.configurations = YAML::load(IO.read("#{RailsRoot}/config/database.yml"))
ActiveRecord::Base.establish_connection(RailsEnv)

def run(domain)
  CrawlerLogger.info "crawler is starting for #{domain} with #{RailsEnv}"
  site = "Crawler::Sites::#{domain.classify}".constantize.new
  site.load
end

if ['lowes.ca'].include? ARGV[0]
 run(ARGV[0].gsub(/\./, '_')) 
else
  CrawlerLogger.info "You need to pass valid params first"
end