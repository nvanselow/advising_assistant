class MeetingSummariesController < ApplicationController
  before_filter :authenticate_user!
  before_filter only: [:create] do
    check_permissions(Meeting.find(params[:meeting_id]))
  end

  def create
    meeting = Meeting.find(params[:meeting_id])

    MeetingSummaryMailer.new_summary(meeting).deliver_later

    flash[:success] = 'Summary email sent!'
    redirect_to meeting_path(meeting)
  end
end
