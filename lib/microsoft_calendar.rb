require 'ruby_outlook'

class MicrosoftCalendar
  outlook_client = RubyOutlook::Client.new
  cattr_accessor :outlook_client

  def initialize(user = nil)
    return nil if !user
    @user = user
    token = Identity.where(user: user, provider: 'microsoft_office365').first
    return nil if !token
    @access_token = token.access_token
    @expires_at = token.expires_at

    if expired?
      raise Errors::TokenExpired
    end
  end

  def get_calendars
    url = 'https://outlook.office.com/api/v2.0/me/calendars'
    calendars = outlook_client.make_api_call('GET', url, @token)
    return JSON.parse(calendars)
  end

  def create_meeting(meeting, calendar_id = nil, notify = true)

    outlook_client.create_event(@token,
                                microsoft_meeting(meeting),
                                calendar_id)
  end

  private

  def microsoft_meeting(meeting)
    start_time = meeting.start_time.to_datetime.to_s
    end_time = meeting.end_time.to_datetime.to_s

    {
      'Subject': meeting.description,
      'Start': {
        'DateTime': start_time,
        'TimeZone': 'UTC'
      },
      'End': {
        'DateTime': end_time,
        'TimeZone': 'UTC'
      }
    },
    'Attendees': [
      {
        'EmailAddress': {
          'Address': meeting.advisee.email,
          'Name': meeting.advisee.full_name
        },
        'Type': 'Required'
      }
    ]
  end

  def expired?
    @expires_at != nil && Time.zone.now > @expires_at
  end
end
