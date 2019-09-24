class Api::V1::ServicesController < ApplicationController

  require "open-uri"

  skip_before_action :authenticate_user!

  swagger_controller :services, "Service Management"

  swagger_api :weather do
    summary 'Weather information for a requested country'
    notes 'Weather information fetched from OpenWeather API based on provided country name like London'
    param :form, :country, :string, :required, 'Country name'
    response :bad_request
    response :forbidden
    response :unauthorized
    response :created
  end
  def weather
    query = params["country"]
    if query.present?
      data = URI.parse("https://api.openweathermap.org/data/2.5/weather?q=#{query}&appid=42dc6eec2bc37ef42c5c108048e53462").read
      render json: { result: JSON.parse(data) }, status: :ok
    else
      render json: { error: "Please enter country" }, status: :bad_request
    end
  end

end