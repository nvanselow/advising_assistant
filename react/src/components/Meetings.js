import React, { Component, PropTypes } from 'react';
import Flash from '../lib/Flash';
import Errors from './Errors';
import moment from 'moment-timezone/builds/moment-timezone-with-data';
import DateTimePicker from './DateTimePicker';
import Timezones from './Timezones';
import Meeting from './Meeting';

class Meetings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      newMeeting: this.resetMeeting(),
      newMeetingErrors: [],
      meetings: []
    }

    this.changeDescription = this.changeDescription.bind(this);
    this.changeDateTime = this.changeDateTime.bind(this);
    this.changeDuration = this.changeDuration.bind(this);
    this.changeTimezone = this.changeTimezone.bind(this);
    this.saveMeeting = this.saveMeeting.bind(this);
    this.renderMeetings = this.renderMeetings.bind(this);
  }

  resetMeeting() {
    return {
      description: '',
      start_time: '',
      duration: 15,
      timezone: moment.tz.guess()
    }
  }

  changeDescription(event) {
    let meeting = this.state.newMeeting;
    meeting.description = event.target.value;
    this.setState({ newMeeting: meeting });
  }

  changeDateTime(datetime) {
    let meeting = this.state.newMeeting;
    meeting.start_time = datetime;
    this.setState({ newMeeting: meeting });
  }

  changeDuration(event) {
    let meeting = this.state.newMeeting;
    meeting.duration = event.target.value;
    this.setState({ newMeeting: meeting });
  }

  changeTimezone(timezone) {
    let meeting = this.state.newMeeting;
    meeting.timezone = timezone;
    this.setState({ newMeeting: meeting });
  }

  renderMeetings() {
    return this.state.meetings.map((meeting) => {
      return <Meeting key={meeting.id} meeting={meeting} />;
    });
  }

  saveMeeting(event) {
    debugger;
    $.ajax({
      url: `/api/v1/advisees/${this.props.adviseeId}/meetings`,
      method: 'POST',
      data: {
        meeting: this.state.newMeeting
      }
    })
    .done((data) => {
      let meetings = this.state.meetings;
      meetings.unshift(data.meeting);
      this.setState({ meetings: meetings,
                      newMeeting: this.resetMeeting(),
                      newMeetingErrors: [] });
      Flash.success('Meeting created!');
    })
    .fail((response) => {
      let data = response.responseJSON;
      debugger;
      Flash.error(data.message);
      this.setState({ newMeetingErrors: data.errors });
    });
  }

  render() {
    let meeting = this.state.newMeeting;

    return (
      <div className="meetings-container">
        <Errors errors={this.state.newMeetingErrors} />
        <div className="row add-meeting-form">
          <div className="col s12">
            <div className="row">
              <div className="input-field col s12">
                <input type="text"
                       id="meeting_description"
                       name="meeting[description]"
                       value={meeting.description}
                       onChange={this.changeDescription} />
                <label htmlFor="meeting_description">Description</label>
              </div>
            </div>

            <div className="input-field">
              <DateTimePicker id="meeting_start_time"
                              onChange={this.changeDateTime} />
            </div>

            <div className="row">
              <div className="input-field col s12">
                <input type="number"
                       id="meeting_duration"
                       step="5"
                       value={meeting.duration}
                       onChange={this.changeDuration} />
                <label htmlFor="meeting_duration">Duration (min):</label>
              </div>
            </div>


            <div className="input-field">
              <Timezones id="meeting_timezone"
                         label="Timezone"
                         onChange={this.changeTimezone} />
            </div>

            <div className="input-field col s12">
              <button className="btn"
                      id="add_meeting"
                      onClick={this.saveMeeting}>
                <i className="material-icons left">add</i>
                Add Meeting
              </button>
            </div>
          </div>
        </div>
        <div className="meetings">
          {this.renderMeetings()}
        </div>
      </div>
    );
  }
}

export default Meetings;
