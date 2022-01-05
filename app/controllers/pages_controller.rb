class PagesController < ApplicationController
  def home
  end
  
  def rooms
    url = "http://localhost:3000/api/v1/rooms"
    response = RestClient.get(url, headers={Authorization: cookies[:jwt_roomintouch]})
    @rooms = JSON.parse(response)
  end
end
