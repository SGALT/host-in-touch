class ClientsController < ApplicationController
  def index
    @clients = call_api("clients")[:resource].data
  end

  def show
    @client = call_api("clients/#{params[:id]}")[:resource].data
    # raise
  end

  def new
    @client = call_api("clients/new")[:resource].data
    countries_hash = @client.meta.countries.to_h
    @countries = countries_hash.each{|k, v| countries_hash[k] = t("countries.#{k}")} 
  end

  def create
    # raise
    params_json = params.as_json
    response = call_api("clients", method: "post", params: params_json )
    if response[:code] == 200
      redirect_to client_path(response[:resource].data.id)
    else
      @client = response[:resource]
      @errors = response[:errors]
      render :new
    end
  end

  def edit
    @client = call_api("clients/#{params[:id]}")[:resource].data
    countries_hash = @client.meta.countries.to_h
    @countries = countries_hash.each{|k, v| countries_hash[k] = t("countries.#{k}")} 
  end

  def update
    params_json = params.as_json
    response = call_api("clients/#{params[:id]}", method: "patch", params: params_json )
    if response[:code] == 200
      redirect_to client_path(response[:resource].data.id)
    else
      @client = response[:resource]
      @errors = response[:errors]
      render :edit
    end
  end
end
