class Api::V1::ClientsController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :authenticate_user_api_key!

  swagger_controller :clients, "Clients Management"

  swagger_api :index do
    summary "Fetches all clients memberships"
    response :unauthorized
    response :not_acceptable
  end

  def index
    @clients = Client.all
  end

  swagger_api :create do
    summary 'Create a client'
    param :query, :name, :string, :required, 'Client Name'
    response :created
    response :forbidden
    response :unauthorized
  end
  def create
    @client = current_user.clients.create(name: params[:name])
    render 'show'
  end

end