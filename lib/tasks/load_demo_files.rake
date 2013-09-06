#encoding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

namespace :demo do
  namespace :files do
    task :load => :environment do
      load_demo_files
    end

    def load_demo_files
      loop do
        ProductImage.all.each do |image|
          unless image.image_url.blank?
            image.image = open image.image_url
            image.update_attributes(image_url: '') if image.save
          end
        end
        ProductManual.all.each do |manual|
          unless manual.cover_url.blank?
            manual.cover = open manual.cover_url
            manual.update_attributes(cover_url: '') if manual.save
          end
          unless manual.file_url.blank?
            manual.file = open manual.file_url
            manual.update_attributes(file_url: '') if manual.save
          end
        end
        sleep 5
      end
    end
  end
end

