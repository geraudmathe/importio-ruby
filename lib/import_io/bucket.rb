module ImportIo
  class Bucket
    attr_reader  :name, :id, :results

    def initialize content, name, id
      @raw_content = content
      @name = name
      @id = id
      @results = get_results
    end


    def get_results
      @raw_content["tiles"].first["results"].first["pages"].map do |page|
        page["results"].first.merge({"url" => page["pageUrl"]})
      end
    end
  end
end