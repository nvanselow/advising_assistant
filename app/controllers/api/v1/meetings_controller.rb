class Api::V1::MeetingsController < ApiController
  include MeetingParams

  before_filter :authenticate_user!
  before_filter only: [:index, :create] do
    check_permissions(Advisee.find(params[:advisee_id]))
  end
  before_filter only: [:update, :destroy] do
    check_permissions(Meeting.find(params[:id]))
  end

  def index
    advisee = Advisee.find(params[:advisee_id])
    meetings = advisee.meetings.order(start_time: :desc)

    render json: { meetings: meetings }, status: :ok
  end

  def create
    meeting = Meeting.new_from_duration(meeting_params)
    meeting.advisee_id = params[:advisee_id]
    meeting.user = current_user

    if meeting.save
      message = 'Meeting created!'

      render json: { message: message, meeting: meeting }, status: :ok
    else
      message = 'There were problems creating that meeting'
      errors = meeting.errors.full_messages

      render json: { message: message, errors: errors }, status: :bad_request
    end
  end

  def update
    meeting = Meeting.find(params[:id])

    if meeting.update(meeting_params)
      message = 'Meeting updated!'

      render json: { message: message, meeting: meeting }, status: :ok
    else
      message = 'There were problems updating that meeting'
      errors = meeting.errors.full_messages

      render json: { message: message, errors: errors }, status: :bad_request
    end
  end

  def destroy
    Meeting.destroy(params[:id])

    render json: { message: 'Meeting deleted!' }, status: :ok
  end
end
