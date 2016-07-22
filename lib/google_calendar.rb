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

  def create_all_for(event)
    created_events = []
    event.slots.each do |slot|
      if(slot.people.size > 0)
        created_events << create_event(event, slot, event.calendar_id)
      end
    end
    created_events
  end

  def create_event(event, slot, calendar_id = nil)
    if(!calendar_id || calendar_id == "")
      calendar_id = 'primary'
    end
    @event = event
    @slot = slot

    @calendar.insert_event(calendar_id, google_event, send_notifications: true)
  end

  private

  def google_event
    a_google_event = Google::Apis::CalendarV3::Event.new
    a_google_event.summary = @event.name
    a_google_event.location = @event.location if @event.location

    # start_time = @slot.start_time.to_s(:rfc3339).gsub!(/:00\sUTC/, '')
    # end_time = @slot.end_time.to_s(:rfc3339).gsub!(/:00\sUTC/, '')
    start_time = @slot.start_time.in_time_zone(@slot.time_zone).to_datetime.to_s
    end_time = @slot.end_time.in_time_zone(@slot.time_zone).to_datetime.to_s

    a_google_event.start = Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time)
    a_google_event.end = Google::Apis::CalendarV3::EventDateTime.new(date_time: end_time)
    a_google_event.attendees = google_attendees

    a_google_event
  end

  def google_attendees
    attendees = []
    @slot.people.each do |person|
      attendees << build_attendee(person)
    end
    attendees
  end

  def build_attendee(person)
    attendee = Google::Apis::CalendarV3::EventAttendee.new
    attendee.email = person.email
    attendee.display_name = person.name if person.name
    attendee
  end

  def set_authorization
    token = @user.get_token(PROVIDER)
    @calendar.authorization = client_with_token(token)
  end
end
