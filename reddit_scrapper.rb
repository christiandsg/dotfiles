#!/usr/bin/env ruby

##### Getting Images

#reddit_address = "http://www.reddit.com/r/aww.json"
#destination_folder = "/tmp/aww_picture"

#response = RestClient.get(reddit_address)
#response.code 404
#puts "ERROR Response nil" if response.nil?

#hashed_response = JSON.parse(response)

#images = {}
#hashed_response["data"]["children"].each do |entry|
#  id  = entry["data"]["id"]
#  url = entry["data"]["url"]
#  images[id] = url
#end

#puts "#{hashed_response.inspect}"
#images.each { |id, url|
#  File.write("/tmp/aww_picture/#{id}.jpeg", open(url).read, {mode: 'wb'})
#}

#### Downloading Images

module Reddit

  class Page
    require "rest_client"
    require 'json'

    def initialize(subreddit)
      @subreddit = subreddit
      @data = nil
      @response = nil
    end

    def data
      @response ||= RestClient.get(Reddit::Page.data_address(@subreddit))
      @data ||= JSON.parse(@response)
    end

    def images
      @images = [ ]
      data["data"]["children"].each do |entry|
        id  = entry["data"]["id"]
        url = entry["data"]["url"]
        image = Reddit::Image.new(id, url)
        puts "Unmanageable image source: #{url}" unless image.valid?
        @images << image if image.valid?
      end
      @images
    end

    def self.data_address(subreddit)
       raise ArgumentError if subreddit.nil?
      "http://www.reddit.com/r/#{subreddit}.json"
    end
  end

  class Image
    require "open-uri"

    def initialize(id, url)
      @id = id
      @url = self.class.normalize_url(url)
    end

    def id
      @id
    end

    def url
      @url
    end

    def save(folder)
      begin
        File.write("#{folder}#{id}.jpeg", open(url).read, {mode: 'wb'})
        true
      rescue OpenURI::HTTPError
        puts "Error while saving #{self.inspect}"
        false
      end
    end

    def valid?
      !(@id.nil? || @url.nil?)
    end
    private

    def self.normalize_url(url)
      return nil if url.include?("imgur.com/a/") # reject imgur galeries

      url.sub!("https://", "http://")
      return url if url.include?("/i.imgur.com") # is imgur image
      return url.sub("/www.imgur.com", "/i.imgur.com") + ".jpeg" if url.include?("/www.imgur.com") # is imgr link
      return url.sub("/imgur.com", "/i.imgur.com") + ".jpeg" if url.include?("/imgur.com") # is imgr link

      nil # Unknown source so dropping
    end
  end
end

["aww", "corgi"].each do |subreddit_name|
  subreddit = Reddit::Page.new(subreddit_name)
  subreddit_images = subreddit.images
  subreddit_images.each do |image|
    image.save("/tmp/aww_picture/")
  end
end
