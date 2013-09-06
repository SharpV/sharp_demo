module Crawler
  module Sites
    class LowesCa < Site
      Index = 'http://www.lowes.ca'

      def load
        #product_url = 'http://www.lowes.ca/wall-mount-bathroom-sinks/cantrio-koncepts-ps-009-ceramic-series-vitreous-china-hung-wall-mount-bathroom-sink_g417194.html?isku=3970286&linkloc=cataLogProductItemsImage'
        #category = Category.first
        #load_product_page(category, product_url)
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
        product = Product.where(name: product_page.at('h1#prodName').content).first_or_create(description: product_page.at('#prodDesc').content, category_id: category.id, price: price)
        #load_recommended_product(product, product_page)
        #load_coordinating_product(product, product_page)
        load_additional_info(product, product_page)
        #load_product_manuals(product, product_page)
        #load_product_reviews(product, product_page)
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
        product_page.css("#divAltImg img").each do |img|
          img_url = 'http:' + img['src'].gsub('/t/','/x/')
          product_img = ProductImage.new
          product_img.product_id = product.id
          product_img.file = open(img_url)
          product_img.save
        end
      end

      def load_product_manuals(product, product_page)
        product_page.css('#Main_productPage_manuals .advSpecLink').each do |pdf_link|
          manual = ProductManual.where(name: Sanitize.clean(pdf_link.content), product_id: product.id).first_or_create
          manual.cover = open(pdf_link.at('img')['src'])
          manual.file = open(pdf_link['href'])
          manual.save
        end
      end

      def load_recommended_product(product, product_page, ids=[])
        product_page.css('#recommendationContainer6 .gutOut').each do |product_box|
          recommend_product = Product.where(name: product_box.at('img')['alt']).first_or_create
          ids << recommend_product.id
        end
        product.recommended_items = ids.to_json
        product.save
      end

      def load_coordinating_product(product, product_page, ids=[])
        p product.inspect
        product_page.css('.gutOut .gb6 .cfl').each do |product_box|
          pro_link = product_box.at('a[class="tBox l"]')['href']
          c_p = open_link(Index + pro_link)
          coordinating_product = Product.where(name: c_p.at('h1#prodName').content).first_or_create
          ids << coordinating_product.id
        end
        product.coordinating_items = ids.to_json
        product.save
      end

      def load_additional_info(product, product_page, additional_infos=[])
        product_page.css("#Main_productPage_pnlExtraData div.gb24 table tr").each do |additional_info_body|
          arr_temp = []
          additional_info_body.css('td').each do |a_i|
            arr_temp << a_i.content
          end
          additional_infos << arr_temp
        end
        product.additional_info = additional_infos.to_json
        product.save
      end

      private

      def file_from_url(url)
        extname = File.extname(url)
        basename = File.basename(url, extname)
        file = Tempfile.new([basename, extname])
        file.binmode
        open(url) do |data|
          file.write data.read
        end
        file.rewind
        file
      end

    end
  end
end


