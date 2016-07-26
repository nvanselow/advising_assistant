class MeetingSummariesController < ApplicationController
  def create
    meeting = Meeting.find(params[:meeting_id])

    MeetingSummaryMailer.new_summary(meeting).deliver_later

    flash[:success] = 'Summary email sent!'
    redirect_to meeting_path(meeting)
  end
end
