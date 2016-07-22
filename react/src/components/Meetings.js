import React, { Component, PropTypes } from 'react';
import DateTimePicker from './DateTimePicker';
import Timezones from './Timezones';

class Meetings extends Component {
  constructor(props) {
    super(props);

    this.changeTimezone = this.changeTimezone.bind(this);
  }

  changeTimezone(timezone) {
    console.log(timezone);
  }

  render() {
    return (
      <div className="meetings-container">
        <div className="row add-meeting-form">
          <div className="col s12">
            <div className="row">
              <div className="input-field col s12">
                <input type="text" id="meeting_description" name="meeting[description]" />
                <label htmlFor="meeting_description">Description</label>
              </div>
            </div>

            <div className="input-field">
              <DateTimePicker id="meeting_start_time" />
            </div>

            <div className="row">
              <div className="input-field col s12">
                <input type="number" id="meeting_duration" />
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
