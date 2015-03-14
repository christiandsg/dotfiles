#!/usr/bin/env ruby

require 'trollop'

module Reddit

  class Page
    require "rest_client"
    require 'json'

    def initialize(subreddit, limit = 50)
      @subreddit = subreddit
      @limit = limit
      @data = nil
      @response = nil
    end

    def data
      @response ||= RestClient.get(Reddit::Page.data_address(@subreddit, @limit))
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

    def self.data_address(subreddit, limit)
       raise ArgumentError if subreddit.nil?
      "http://www.reddit.com/r/#{subreddit}.json?limit=#{limit}"
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
      rescue SocketError
        false
      end
    end

    def valid?
      !(@id.nil? || @url.nil?)
    end

    private

    def self.normalize_url(url)
      return url if /(jpg|jpeg)$/.match(url) # url already points to an image

      return nil if url.include?("imgur.com/a/") # reject imgur galeries

      url.sub!("https://", "http://")
      return url if url.include?("/i.imgur.com") # is imgur image
      return url.sub("/www.imgur.com", "/i.imgur.com") + ".jpeg" if url.include?("/www.imgur.com") # is imgr link
      return url.sub("/imgur.com", "/i.imgur.com") + ".jpeg" if url.include?("/imgur.com") # is imgr link

      nil # Unknown source so dropping
    end
  end
end

NUM_PICTURES = 100

# Input params
opts = Trollop::options do
  banner <<-EOS
This script downloads the top images of a set of subreddits.
- The number of images to download is fix to 100.
Example: ./reddit_image_downloader.rb -s aww corgi -d /tmp/aww_pictures/
  EOS
  opt :subreddits, "Lists of subreddit names", type: :strings
  opt :destination_folder, "Image folder destination", type: :string
  opt :delete_destination_folder, "Delete destination folder if it exists", short: "-D", type: :boolean, default: false
end

puts "Starting reddit_image_downloader with params '#{opts.inspect}'"

destination_folder = opts[:destination_folder]
FileUtils.rmdir(destination_folder) if opts[:delete_destination_folder]
FileUtils.mkdir(destination_folder) unless Dir.exists?(destination_folder)

opts[:subreddits].each do |subreddit_name|
  puts "Processing subreddit '#{subreddit_name}'"
  subreddit = Reddit::Page.new(subreddit_name, NUM_PICTURES)
  subreddit_images = subreddit.images
  subreddit_images.each do |image|
    image.save(destination_folder)
  end
end

puts "Finished reddit_image_downloader"
