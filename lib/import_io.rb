require 'json'
require "open-uri"
require "cgi"
require "import_io/version"
require "import_io/bucket"
module ImportIo

  BASE_URL = "https://api.import.io/"
  
  class Crawler
    

    def initialize user_id, api_key
      @user_id = CGI::escape(user_id)
      @api_key = CGI::escape(api_key)
    end

    def get_bucket bucket_id
      @bucket_id = bucket_id
      req = request get_url
      #puts get_url(req["snapshot"])
      body =  request get_url(req["snapshot"])
      Bucket.new body, req["name"], bucket_id
    end

    def get_url snapshot = nil
      args = [BASE_URL, "store/connector/", @bucket_id]
      args.concat ["/_attachment/snapshot/", snapshot] unless snapshot.nil?
      args.push("?_user=#{@user_id}&_apikey=#{@api_key}").join 
    end

    def all
      response = request "https://api.import.io/store/connector/_search?_mine=true&_user=#{@user_id}&_apikey=#{@api_key}"
      response["hits"]["hits"]
    end

    def request url
      JSON.parse open(url).read
    end
  end
end


