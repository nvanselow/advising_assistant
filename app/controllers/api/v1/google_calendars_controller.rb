class Api::V1::GoogleCalendarsController < ApplicationController
  def index
    calendar_api = GoogleCalendar.new(current_user)
    render json: { calendars: calendar_api.get_calendars }
  end
end
