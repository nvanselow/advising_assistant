class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  rescue_from Errors::TokenExpired, with: :token_error

  protected

  def token_error
    service = 'Google'
    if params[:controller].include?('microsoft')
      service = 'Microsoft'
    end
    render json: { message: "Your link to #{service} has expired. "\
                            'Please authorize again.' }, status: :unauthorized
  end
end
