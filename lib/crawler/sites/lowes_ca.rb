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
        CrawlerLogger.error "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
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
            CrawlerLogger.error "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
          end
        end
      end

      def load_product_page(category, link)
        return if CrawlerMeta.where(url: link, status: CrawlerMeta::STATUS[:HAVE_SYN]).first
        CrawlerLogger.info "load product page......"
        product_page = open_link(link)
        price = product_page.at('#divPrice').content.match(/\d+.\d/).to_s.to_f
        product_params = {description: product_page.at('#prodDesc').content,  price: price}
        product = Product.where(name: product_page.at('h1#prodName').content).first_or_create(product_params)
        load_recommended_product(product, product_page)
        load_coordinating_product(product, product_page)
        load_additional_info(product, product_page)
        load_product_reviews(product, product_page)
        load_product_manuals(product, product_page)
        load_product_images(product, product_page)
        product.category = category
        if product.save
          CrawlerMeta.create url: link, status: CrawlerMeta::STATUS[:HAVE_SYN], product_id: product.id
        end
      end 

      def load_product_reviews(product, product_page)
        review_link = nil
        product_page.css("div.cBlock div a").each do |review_a|
          if review_a['href'] =~ /reviews/
            review_link = review_a['href']
            break
          end
        end
        if review_link
          review_page = open_link(Index + review_link)
          review_page.css('#contentWrapper div.rvwBlk').each do |review_box|
            author = "Lowe's Guest"
            city = review_box.at(".rvwBlkL span").content.strip() rescue ''
            star = review_box.at(".rvwStar")["style"].match(/\-(\d+)px/)[1].to_s.to_f / 32 rescue 0
            title = review_box.at(".rvwBlkR strong").content rescue ''
            body = review_box.at(".rvwBlkR div[style='margin-top: 5px;']").content.strip() rescue ''
            created_at = review_box.at(".rvwBlkL").content.match(/[Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec]+ \d+, \d+/).to_s.to_date rescue Time.now
            Review.where(product_id: product.id, created_at: created_at, body: body).first_or_create(title: title, author: author, star: star, city: city)
          end
        else
          product_page.css("div[itemprop='review']").each do |review_box|
            star = review_box.at('span[itemprop="ratingValue"]').content rescue 0
            title = review_box.at('strong[itemprop="name"]').content rescue ''
            created_at = review_box.at('span[itemprop="datePublished"]').content.to_date rescue Time.now
            author = review_box.at('span[itemprop="author"]').content rescue ''
            body = review_box.at('div[itemprop="description"]').content rescue ''
            Review.where(product_id: product.id, created_at: created_at, body: body).first_or_create(title: title, author: author, star: star)
          end
        end
      end

      def load_product_images(product, product_page)
        scorll_imgs = product_page.css("#altImageScrollbar .altImg img")
        if scorll_imgs and scorll_imgs.size > 0
          scorll_imgs.each do |img|
            img_url = img['src'].gsub('/t/','/x/').gsub(/http:/, '')
            ProductImage.create!(product_id: product.id, image_url: 'http:'+img_url)
          end
        else
          product_page.css("#divMainImg img").each do |img|
            img_url = img['src'].gsub('/t/','/x/').gsub(/http:/, '')
            ProductImage.create!(product_id: product.id, image_url: 'http:'+img_url)
          end
        end
      rescue Exception => e
        CrawlerLogger.error e.inspect
        CrawlerLogger.error "load_product_images: \n Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      end

      def load_product_manuals(product, product_page)
        product_page.css('#Main_productPage_manuals .advSpecLink').each do |pdf_link|
          manual = ProductManual.where(name: Sanitize.clean(pdf_link.content), product_id: product.id).first_or_create
          manual.cover_url = 'http:' + pdf_link.at('img')['src']
          manual.file_url = pdf_link['href']
          manual.save
        end
      rescue Exception => e
        CrawlerLogger.error e.inspect
        CrawlerLogger.error "load_product_manuals: \n Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      end

      def load_recommended_product(product, product_page, ids=[])
        product_page.css('#recommendationContainer6 .gutOut').each do |product_box|
          recommend_product = Product.where(name: product_box.at('img')['alt']).first_or_create
          ids << recommend_product.id
        end
        product.update_attributes(recommended_items: ids) unless ids.blank?
      end

      def load_coordinating_product(product, product_page, ids=[])
        product_page.css('.gutOut .gb6 .cfl').each do |product_box|
          pro_link = product_box.at('a[class="tBox l"]')['href']
          c_p = open_link(Index + pro_link)
          coordinating_product = Product.where(name: c_p.at('h1#prodName').content).first_or_create
          ids << coordinating_product.id
        end
        product.update_attributes(coordinating_items: ids) unless ids.blank?
      end

      def load_additional_info(product, product_page, additional_infos=[])
        product_page.css("#Main_productPage_pnlExtraData div.gb24 table tr").each do |additional_info_body|
          arr_temp = []
          additional_info_body.css('td').each do |a_i|
            arr_temp << a_i.content
          end
          additional_infos << arr_temp
        end
        product.update_attributes(additional_info: additional_infos) unless additional_infos.blank?
      end
    end
  end
end


