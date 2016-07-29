class Api::V1::MeetingNotesController < ApiController
  include NoteParams

  before_filter :authenticate_user!
  before_filter only: [:index, :create] do
    check_permissions(Meeting.find(params[:meeting_id]))
  end

  def index
    meeting = Meeting.find(params[:meeting_id])
    notes = meeting.notes.order(updated_at: :desc)

    render json: { meeting: meeting, notes: notes }, status: :ok
  end

  def create
    meeting = Meeting.find(params[:meeting_id])
    note = meeting.notes.new(notes_params)

    if note.save
      render json: { note: note, message: 'Note created!' }, status: :ok
    else
      errors = note.errors.full_messages

      render json: {
        note: note,
        message: 'There were problems creating that note.',
        errors: errors
      }, status: :bad_request
    end
  end
end
