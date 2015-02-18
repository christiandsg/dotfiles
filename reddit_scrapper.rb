#!/usr/bin/env ruby

require 'json'
require "rest_client"
require "open-uri"

##### Getting Images

reddit_address = "http://www.reddit.com/r/aww.json"
destination_folder = "/tmp/aww_picture"

response = RestClient.get(reddit_address)
#response.code 404
puts "ERROR Response nil" if response.nil?

hashed_response = JSON.parse(response)

images = {}
hashed_response["data"]["children"].each do |entry|
  id  = entry["data"]["id"]
  url = entry["data"]["url"]
  images[id] = url
end

#puts "#{hashed_response.inspect}"
images.each { |id, url|
  File.write("/tmp/aww_picture/#{id}.jpeg", open(url).read, {mode: 'wb'})
}

#### Downloading Images

class RedditResponse
  include JSON
  def valid?(response)
  end
end
