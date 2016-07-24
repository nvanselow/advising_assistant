class Api::V1::GoogleCalendarsController < ApiController
  before_filter :authenticate_user!

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
    render json: { message: 'Your link to Google has expired. Please authorize again.' }, status: :unauthorized
  end
end
