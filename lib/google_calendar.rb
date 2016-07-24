require 'google/apis/calendar_v3'
require_relative 'google_client'

class GoogleCalendar
  @@calendar_service = Google::Apis::CalendarV3::CalendarService
  cattr_accessor :calendar_service
  include GoogleClient

  PROVIDER = 'google_oauth2'.freeze
  SimpleCalendar = Struct.new(:id, :name, :time_zone)

  def initialize(user)
    @user = user
    @calendar = calendar_service.new
    @event = nil
    @slot = nil
    super
    set_authorization
  end

  def get_calendars
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
    if !calendar_id || calendar_id == ""
      calendar_id = 'primary'
    end
    @meeting = meeting

    @calendar.insert_event(calendar_id,
                           google_meeting,
                           send_notifications: notify)
  end

  private

  def google_meeting
    google_event = Google::Apis::CalendarV3::Event.new
    google_event.summary = @meeting.description

    start_time = @meeting.start_time.to_datetime.to_s
    end_time = @meeting.end_time.to_datetime.to_s

    google_event.start =
      Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time,
                                                  time_zone: 'Etc/UTC')
    google_event.end =
      Google::Apis::CalendarV3::EventDateTime.new(date_time: end_time,
                                                  time_zone: 'Etc/UTC')
    google_event.attendees = [build_attendee(@meeting.advisee)]

    google_event
  end

  def build_attendee(person)
    attendee = Google::Apis::CalendarV3::EventAttendee.new
    attendee.email = person.email
    attendee.display_name = person.full_name
    attendee
  end

  def set_authorization
    token = @user.identities.where(provider: 'google_oauth2').first
    raise Errors::MissingToken unless token

    @calendar.authorization = client_with_token(token)
  end
end
