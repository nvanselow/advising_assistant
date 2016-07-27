class Api::V1::UpcomingMeetingsController < ApiController
  before_filter :authenticate_user!

  def index
    meetings = Meeting.upcomming_for_user(current_user).includes(:advisee)

    render json: { meetings: Meeting.format_for_upcoming(meetings) }
  end
end
