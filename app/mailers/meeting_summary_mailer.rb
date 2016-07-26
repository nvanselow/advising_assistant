class MeetingSummaryMailer < ApplicationMailer
  def new_summary(meeting)
    @meeting = meeting
    @advisee = meeting.advisee
    @user = meeting.user

    mail(
      to: @advisee.email,
      bcc: @user.email,
      subject: "#{meeting.formatted_start_time} Meeting Summary"
    )
  end
end
