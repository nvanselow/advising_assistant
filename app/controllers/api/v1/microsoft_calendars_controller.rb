class Api::V1::MicrosoftCalendarsController < ApiController
  before_filter :authenticate_user!

  def index
    calendar_service = MicrosoftCalendar.new(current_user)

    calendars = calendar_service.get_calendars

    render json: { calendars: calendars }, status: :ok
  end

  def create
    calendar_service = MicrosoftCalendar.new(current_user)
  end
end
