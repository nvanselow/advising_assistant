module NoteParams
  protected
  
  def notes_params
    params.require(:note).permit(:body)
  end
end
