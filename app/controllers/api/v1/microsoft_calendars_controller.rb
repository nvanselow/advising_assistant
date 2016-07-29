class Api::V1::MicrosoftCalendarsController < ApiController
  before_filter :authenticate_user!
  before_filter only: [:create] do
    check_permissions(Meeting.find(params[:meeting_id]))
  end

  def index
    calendar_service = MicrosoftCalendar.new(current_user)
    render json: { calendars: calendar_service.get_calendars }, status: :ok
  end

  def create
    meeting = Meeting.find(params[:meeting_id])
    calendar_service = MicrosoftCalendar.new(current_user)
    calendar_service.create_meeting(meeting, params[:calendar], params[:notify])

    render json: { message: 'Meeting added to calendar!' }, status: :ok
  end
end
