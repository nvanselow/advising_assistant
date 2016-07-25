def valid_start_dates
  [
    '2016-01-22 11:00',
    '2014-12-11 05:00',
    '2015-03-11 18:00',
    '2015-11-05 8:00am'
  ]
end

def invalid_start_dates
  ['2016', 'abc', 123]
end

def valid_end_dates
  [
    '2016-01-23 11:00',
    '2016-12-11 05:00',
    '2017-03-11 18:00',
    '2017-11-05 8:00pm'
  ]
end

def invalid_end_dates
  ['2016', 'abc', 123]
end

def get_note_ids(json)
  json['notes'].map { |c| c['id'] }
end

def get_meeting_ids(json)
  json['meetings'].map { |c| c['id'] }
end
