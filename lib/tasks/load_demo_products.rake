#encoding: utf-8 
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uuid'

namespace :demo do
  namespace :products do
    task :load => :environment do
      load_demo_product
    end

    task :reset => :environment do
      Product.delete_all
      Category.delete_all
    end
    
    def load_demo_product
      puts "load demo product......"
      index = 'http://www.lowes.ca'
      index_page = open_link(index)
      index_page.css('#ulTopNavType li a').each do |first_category_link|
        begin
          first_category = Category.where(name: first_category_link.content).first_or_create
          first_category_page = open_link(index + first_category_link['href'])
          puts "load page #{first_category_link.content}"
          first_category_page.css('#divCatWrapper .divcat200type').each do |category_box|
            next_link = category_box.at('.alignCenter a')
            second_category = Category.where(name: next_link.content, parent_id: first_category.id).first_or_create
            second_category_page = open_link(index + next_link['href'])
            second_category_page.css('#divCatWrapper .divcat200type').each do |category_box|
              next_link = category_box.at('.alignCenter a')
              third_category = Category.where(name: next_link.content, parent_id: second_category.id).first_or_create
              third_category_page = open_link(index + next_link['href'])
              third_category_page.css('.catItem').each do |product_box|
                product_link = product_box.at('a.catImg')
                product_page = open_link(index + product_link['href'])
                price = product_page.at('#divPrice').content.match(/\d+.\d/).to_s.to_f
                recommend = product_page.at("span[itemprop='ratingValue']").content
                pic_url = product_page.at("#divMainImg img").src
                product = Product.where(name: product_page.at('#prodName').content).first_or_create(description: product_page.at('#prodDesc').content, category_id: third_category.id, price: price )
              end
            end
          end
        rescue Exception => e
          puts "----- #{e.inspect}"
        end
      end
    end
    
    def open_link(link)
      puts "open link #{link}..."
      Nokogiri::HTML(open(link))
    end
  end
end
