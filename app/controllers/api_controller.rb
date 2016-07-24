class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  rescue_from Errors::TokenExpired, with: :token_error

  protected

  def token_error
    service = 'Google'
    provider = 'google_oauth2'
    if params[:controller].include?('microsoft')
      service = 'Microsoft'
      provider = 'microsoft_office365'
    end
    render json: {
      message: "Your link to #{service} has expired. Please authorize again.",
      provider: provider
    }, status: :unauthorized
  end
end
