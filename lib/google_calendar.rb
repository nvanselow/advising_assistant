require 'google/apis/calendar_v3'
require_relative 'google_client'

class GoogleCalendar
  include GoogleClient

  PROVIDER = 'google_oauth2'
  SimpleCalendar = Struct.new(:id, :name, :time_zone)

  def initialize(user)
    @user = user
    @calendar = Google::Apis::CalendarV3::CalendarService.new
    @event = nil
    @slot = nil
    super
    set_authorization
  end

  def get_calendars
    # CalendarList.items (array of CalendarListEntry)
      # CalendarListEntry
        # id
        # summary
        # time_zone
    calendars = @calendar.list_calendar_lists(min_access_role: "writer")
    simple_calendars = []
    calendars.items.each do |calendar|
      simple_calendars << SimpleCalendar.new(calendar.id,
                                             calendar.summary,
                                             calendar.time_zone)
    end
    simple_calendars
  end

  def create_meeting(meeting, calendar_id = nil, notify = true)
    if(!calendar_id || calendar_id == "")
      calendar_id = 'primary'
    end
    @meeting = meeting

    @calendar.insert_event(calendar_id,
                           google_meeting,
                           send_notifications: notify)
  end

  private

  def google_event
    a_google_event = Google::Apis::CalendarV3::Event.new
    a_google_event.summary = @meeting.description
    a_google_event.location = @meeting.location if @meeting.location

    start_time = @meeting.start_time
    end_time = @meeting.end_time

    a_google_event.start =
      Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time,
                                                  time_zone: 'Etc/UTC')
    a_google_event.end =
      Google::Apis::CalendarV3::EventDateTime.new(date_time: end_time,
                                                  time_zone: 'Etc/UTC')
    a_google_event.attendees = build_attendee(@meeting.advisee)

    a_google_event
  end

  def build_attendee(person)
    attendee = Google::Apis::CalendarV3::EventAttendee.new
    attendee.email = person.email
    attendee.display_name = person.full_name
    attendee
  end

  def set_authorization
    token = @user.identities.where(provider: 'google_oauth2').first
    @calendar.authorization = client_with_token(token)
  end
end
