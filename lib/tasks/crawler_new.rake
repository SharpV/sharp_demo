#encoding: utf-8
require 'rubygems'
require 'open-uri'
require 'json'
INDEX =  'http://scapi.shoplocal.com/lowes/2010.3/json/'

namespace :demo do
  namespace :new do
    task :load => :environment do
      load_data
    end

    def load_data
      begin
        storeid = get_store_info
        promotionid = get_promotion_info(storeid)
        get_ad_info(storeid, promotionid)
      rescue Exception => e
        p e.to_s
      end
    end

    def get_ad_info(storeid, promotionid)
      uri = INDEX + "getpromotionpages.aspx?campaignid=e3ee194dc40221d8&storeid=#{storeid}&promotionid=#{promotionid}&pageimagewidth=740&languageid=1"
      ads = open_uri_and_return_json(uri)
      ads["content"]["collection"][0]["data"].each do |ad|
        ZipImage.create(image_url: ad["imageurl"], zipcode: ENV['zipcode'])
      end
      ZipImage.create(image_url: "exit_flag", zipcode: ENV['zipcode'])
    end

    def get_store_info
      uri = INDEX + "getstore.aspx?campaignid=e3ee194dc40221d8&languageid=1&citystatezip=#{ENV['zipcode']}&ignorecontentflag=y"
      store = open_uri_and_return_json(uri)
      p city = store["content"]["collection"]["data"]["city"]
      p storeid = store["content"]["collection"]["data"]["storeid"]
      p zipcode = store["content"]["collection"]["data"]["zipcode5"]
      #TODO: save the data into database
      storeid
    end

    def get_promotion_info(storeid)
      uri = INDEX + "getpromotions.aspx?campaignid=e3ee194dc40221d8&storeid=#{storeid}&pageimagewidth=200&languageid=1&promotioncount=999"
      promotion = open_uri_and_return_json(uri)
      p promotionid = promotion["content"]["collection"]["data"]["promotionid"]
      #TODO: save the data into database
      promotionid
    end

    def open_uri_and_return_json(uri)
      response = nil
      open(uri) do |http|
        response = http.read
      end
      JSON::parse(response)
    end

  end

end

