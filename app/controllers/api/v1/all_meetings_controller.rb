class Api::V1::AllMeetingsController < ApiController
  before_filter :authenticate_user!
  
  def index
    meetings = Meeting.where(user: current_user).includes(:advisee)

    render json: { meetings: Meeting.format_for_upcoming(meetings) }
  end
end
