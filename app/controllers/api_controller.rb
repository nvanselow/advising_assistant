class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :set_current_url

  rescue_from Errors::TokenExpired, with: :handle_token_error
  rescue_from Errors::MissingToken, with: :handle_missing_token

  protected

  def set_current_url
    current_url = params[:current_url] || request.path
    store_location_for(:user, current_url)
  end

  def handle_token_error
    get_service

    render json: {
      message: "Your link to #{@service} has expired. Please authorize again.",
      provider: @provider
    }, status: :unauthorized
  end

  def handle_missing_token
    get_service

    render json: {
      message: "You have not linked your account to #{@service}. "\
               "Redirecting you to do so now.",
      provider: @provider
    }, status: :unauthorized
  end

  def get_service
    @service = 'Google'
    @provider = 'google_oauth2'

    if params[:controller].include?('microsoft')
      @service = 'Microsoft'
      @provider = 'microsoft_office365'
    end
  end
end
