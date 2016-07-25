class Api::V1::NotesController < ApiController
  include NoteParams

  before_filter :authenticate_user!

  def update
    note = Note.find(params[:id])

    if note.update(notes_params)
      render json: { message: 'Note updated!', note: note }, status: :ok
    else
      errors = note.errors.full_messages

      render json: {
                      message: 'There were problems updating the note.',
                      errors: errors
                   }, status: :bad_request
    end
  end

  def destroy
    Note.destroy(params[:id])

    render json: { message: 'Note deleted!' }, status: :ok
  end
end
