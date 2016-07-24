class FakeGoogleCalendarService
  attr_accessor :authorization

  def list_calendar_lists(min_access_role:)
    calendar1 = Google::Apis::CalendarV3::CalendarListEntry.new
    calendar1.access_role = "owner"
    calendar1.id = 'main@gmail.com'
    calendar1.summary = 'main@gmail.com'
    calendar1.time_zone = 'America/New_York'

    calendar2 = Google::Apis::CalendarV3::CalendarListEntry.new
    calendar2.access_role = "owner"
    calendar2.id = '123456@group.calendar.google.com'
    calendar2.summary = 'Test Calendar'
    calendar2.time_zone = 'America/New_York'

    list = Google::Apis::CalendarV3::CalendarList.new
    list.items = [
      calendar1,
      calendar2
    ]

    list
  end

  def insert_event(_calendar_id, event, send_notifications:)
    event.id = '1234'
    event.kind = 'calendar#event'

    event
  end
end
