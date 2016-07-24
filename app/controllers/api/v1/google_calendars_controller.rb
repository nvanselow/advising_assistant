class Api::V1::GoogleCalendarsController < ApplicationController
  rescue_from Errors::TokenExpired, with: :token_error

  def index
    calendar_api = GoogleCalendar.new(current_user)
    render json: { calendars: calendar_api.get_calendars }
  end

  protected

  def token_error
    redirect_to '/auth/google_oauth2'
  end
end
