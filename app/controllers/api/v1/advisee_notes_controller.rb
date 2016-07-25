class Api::V1::AdviseeNotesController < ApiController
  include NoteParams

  before_filter :authenticate_user!

  def index
    advisee = Advisee.find(params[:advisee_id])
    notes = advisee.notes.order(updated_at: :desc)

    render json: { notes: notes }, status: :ok
  end

  def create
    advisee = Advisee.find(params[:advisee_id])

    note = advisee.notes.new(notes_params)

    if note.save
      render json: { note: note, message: 'Note created!' }, status: :ok
    else
      errors = note.errors.full_messages

      render json: { note: note,
                     message: 'There were problems creating that note.',
                     errors: errors
                   }, status: :bad_request
    end
  end
end
