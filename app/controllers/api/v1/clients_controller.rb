class Api::V1::ClientsController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :authenticate_api_key!

  swagger_controller :clients, "Clients Management"

  swagger_api :index do
    summary "Fetches all clients memberships"
    response :unauthorized
    response :not_acceptable
  end

  def index
    render json: { clients: Client.all.to_json() }
  end

  private
  def authenticate_api_key!
    render json: { error: "Invalid API key" }, status: 401 if request.env["HTTP_X_API_KEY"] != "abc"
  end

end