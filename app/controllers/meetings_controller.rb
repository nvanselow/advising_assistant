class MeetingsController < ApplicationController
  include MeetingParams

  before_filter :authenticate_user!

  def show
    @meeting = Meeting.find(params[:id])
    @advisee = @meeting.advisee
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])

    if Meeting.update_from_duration(@meeting, meeting_params)
      flash[:success] = 'Meeting updated!'
      redirect_to meeting_path(@meeting)
    else
      flash[:error] = 'There were problems updating that meeting'
      @errors = @meeting.errors.full_messages
      render 'meetings/edit'
    end
  end

  def destroy
    Meeting.destroy(params[:id])

    flash[:success] = 'Meeting deleted!'

    redirect_to advisees_path
  end
end
