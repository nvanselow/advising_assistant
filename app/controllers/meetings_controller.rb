class MeetingsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @meeting = Meeting.find(params[:id])
    @advisee = @meeting.advisee
  end
end
