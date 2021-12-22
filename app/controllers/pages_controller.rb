class PagesController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'

  def home
  end
  
  def rooms
    url = "http://localhost:3000/api/v1/rooms"
    puts cookies[:jwt_roomintouch]
    response = RestClient.get(url, headers={Authorization: cookies[:jwt_roomintouch]})
    @rooms = JSON.parse(response)
  end
end
