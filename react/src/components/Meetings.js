import React, { Component, PropTypes } from 'react';
import moment from 'moment-timezone/builds/moment-timezone-with-data';
import DateTimePicker from './DateTimePicker';
import Timezones from './Timezones';

class Meetings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      newMeeting: {
        description: '',
        date: '',
        duration: 15,
        timezone: moment.tz.guess()
      }
    }

    this.changeDescription = this.changeDescription.bind(this);
    this.changeDateTime = this.changeDateTime.bind(this);
    this.changeDuration = this.changeDuration.bind(this);
    this.changeTimezone = this.changeTimezone.bind(this);
  }

  changeDescription(event) {
    let meeting = this.state.newMeeting;
    meeting.description = event.target.value;
    this.setState({ newMeeting: meeting });
  }

  changeDateTime(datetime) {
    let meeting = this.state.newMeeting;
    meeting.date = datetime;
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

  render() {
    let meeting = this.state.newMeeting;

    return (
      <div className="meetings-container">
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
              <button className="btn">
                <i className="material-icons left">add</i>
                Add Meeting
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Meetings;
