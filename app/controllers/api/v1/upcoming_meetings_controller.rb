class Api::V1::UpcomingMeetingsController < ApiController
  def index
    meetings = Meeting.upcomming_for_user(current_user).includes(:advisee)

    meetings = meetings.map do |meeting|
      advisee = meeting.advisee

      {
        id: meeting.id,
        description: meeting.description,
        start_time: meeting.start_time,
        end_time: meeting.end_time,
        duration: meeting.duration,
        advisee: {
          id: advisee.id,
          full_name: advisee.full_name,
          first_name: advisee.first_name,
          last_name: advisee.last_name
        }
      }
    end

    render json: { meetings: meetings }, status: :ok
  end
end
