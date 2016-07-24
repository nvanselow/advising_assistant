class Api::V1::GoogleCalendarsController < ApplicationController
  rescue_from Errors::TokenExpired, with: :token_error

  def index
    calendar_api = GoogleCalendar.new(current_user)
    render json: { calendars: calendar_api.get_calendars }
  end

  def create
    meeting = Meeting.find(params[:meeting_id])
    calendar_service = GoogleCalendar.new(current_user)
    calendar_service.create_meeting(meeting, params[:calendar], params[:notify])

    render json: { message: 'Meeting added to calendar!' }, status: :ok
  end

  protected

  def token_error
    redirect_to '/auth/google_oauth2'
  end
end
