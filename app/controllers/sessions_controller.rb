class SessionsController < ApplicationController
  def new
  end

  def create
    url = "http://localhost:3000/api/v1/hotels/sign_in"
    email = params[:user][:email]
    password = params[:user][:password]

    begin 
      response = RestClient.post(url, {email: email, password: password})
      cookies[:jwt_roomintouch] = JSON.parse(response)["jwt"]
      redirect_to root_path
    rescue RestClient::ExceptionWithResponse => e
      errors = JSON.parse(e.response.body)["errors"].to_a.join
      redirect_to new_hotel_session, alert: errors
    end
  end

  def destroy
    cookies[:jwt_roomintouch] = nil
  end
end
