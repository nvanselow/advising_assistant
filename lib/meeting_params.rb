module MeetingParams
  protected

  def meeting_params
    params.require(:meeting).permit(:description,
                                    :start_time,
                                    :end_time,
                                    :duration)
  end
end
