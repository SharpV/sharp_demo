module Crawler
  module Sites
    class LowesCa < Site
      Index = 'http://www.lowes.ca'

      def load
        start
      rescue SystemExit, Interrupt
        raise
      rescue Exception => e
        CrawlerLogger.error "#{e.inspect}"
      end

      def start
        CrawlerLogger.info "load demo product......"
        index_page = open_link(Index)
        index_page.css('#ulTopNavType li a').each do |first_category_link|
          sleep IntervalTime
          begin
            first_category = Category.where(name: first_category_link.content).first_or_create
            first_category_page = open_link(Index + first_category_link['href'])
            CrawlerLogger.info "load page #{first_category_link.content}"
            first_category_page.css('#divCatWrapper .divcat200type').each do |category_box|
              sleep IntervalTime
              next_link = category_box.at('.alignCenter a')
              second_category = Category.where(name: next_link.content, parent_id: first_category.id).first_or_create
              second_category_page = open_link(Index + next_link['href'])
              second_category_page.css('#divCatWrapper .divcat200type').each do |category_box|
                sleep IntervalTime
                next_link = category_box.at('.alignCenter a')
                third_category = Category.where(name: next_link.content, parent_id: second_category.id).first_or_create
                third_category_page = open_link(Index + next_link['href'])
                third_category_page.css('.catItem').each do |product_box|
                  sleep IntervalTime
                  product_link = Index + product_box.at('a.catImg')['href']
                  load_product_page(third_category, product_link)
                end
              end
            end
          rescue Exception => e
            CrawlerLogger.error "#{e.inspect}"
          end
        end
      end

      def load_product_page(category, link)
        product_page = open_link(link)
        price = product_page.at('#divPrice').content.match(/\d+.\d/).to_s.to_f
        #recommend = product_page.at("span[itemprop='ratingValue']").content
        #pic_url = product_page.at("#divMainImg img")['src']

        product = Product.where(name: product_page.at('#prodName').content).first_or_create(description: product_page.at('#prodDesc').content, category_id: category.id)        
        load_recommended_product(product, product_page)
        load_coordinating_product(product, product_page)
        load_related_product(product, product_page)
      end 

      def load_product_reviews(product, product_page)

      end

      def load_product_images(product, product_page)

      end

      def load_product_manuals(product, product_page)

      end

      def load_recommended_product(product, product_page, ids=[])
        product_page.css('#recommendationContainer6 .gutOut').each do |product_box|
          recommend_product = Product.where(name: product_box.at('img')['alt']).first_or_create
          ids << recommend_product.id
        end
        product.recommend_items = ids.to_json
        product.save
      end

      def load_coordinating_product(product, product_page, ids=[])


      end


      def load_related_product(product, product_page, ids=[])

      end
    end
  end
end

