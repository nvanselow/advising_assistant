class Api::V1::UpcomingMeetingsController < ApiController
  def index
    meetings = Meeting.upcomming_for_user(current_user).includes(:advisee)

    render json: { meetings: Meeting.format_for_upcoming(meetings) }
  end
end
