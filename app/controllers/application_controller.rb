class ApplicationController < ActionController::Base
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  require 'ostruct'

  def call_api(path, arg={method: "get"})
    url = "http://localhost:3000/api/v1/#{path}"
    response = RestClient::Request.new( {
      method: arg[:method],
      url: url,
      payload: arg[:params],
      headers: { Authorization: cookies[:jwt_roomintouch] }
    }).execute do |response, request, result|
      case response.code
      when 200
         parsed_response = JSON.parse(response, object_class: OpenStruct)
        { code:response.code ,resource: parsed_response }
      else
        parsed_response = JSON.parse(response, object_class: OpenStruct)
        { 
          code:response.code, 
          resource: parsed_response.errors[0], 
          errors: parsed_response.errors[1..-1]
        }
      end
    end
  end

  def token
    @token = cookies[:jwt_roomintouch]
  end
end
