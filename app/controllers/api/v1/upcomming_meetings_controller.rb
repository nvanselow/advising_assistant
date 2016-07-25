class Api::V1::UpcommingMeetingsController < ApiController
  def index
    meetings = Meeting.upcomming_for_user(current_user)

    render json: { meetings: meetings }, status: :ok
  end
end
