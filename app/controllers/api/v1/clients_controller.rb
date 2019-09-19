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

  swagger_api :create do
    summary 'Create a client'
    param :query, :name, :string, :required, 'Client Name'
    response :created
    response :forbidden
    response :unauthorized
  end
  def create
    client = current_user.clients.new(name: params[:name])
    if client.save
      render json: { name: client.name, api_key: client.api_key }, status: :created
    else
      render json: { error: client.errors }, status: :bad_request
    end
  end


  private
  def authenticate_api_key!
    render json: { error: "Invalid API key" }, status: 401 if request.env["HTTP_X_API_KEY"] != "abc"
  end

end