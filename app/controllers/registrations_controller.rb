class RegistrationsController < ApplicationController
  def new
  end

  def create
    url = "http://localhost:3000/api/v1/hotels"
    params_json = params.as_json
    begin 
      response = RestClient.post(url, params_json)
      cookies[:jwt_roomintouch] = JSON.parse(response)["jwt"]
      redirect_to root_path
    rescue RestClient::ExceptionWithResponse => e
      errors = JSON.parse(e.response.body)["errors"].join(", ")
      redirect_to new_registration_path, alert: errors
    end
  end

  def edit
  end

  def update
  end
end
