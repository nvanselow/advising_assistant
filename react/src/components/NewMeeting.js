import React from 'react';
import DateTimePicker from './DateTimePicker';
import Errors from './Errors';

let NewMeeting = (props) => {
  let meeting = props.meeting;

  return (
    <div>
      <Errors errors={props.errors} />
      <div className="row add-meeting-form">
        <div className="col s12">
          <div className="card orange lighten-5">
            <div className="card-content">
              <span className="card-title">
                New Meeting
              </span>
              <div className="row">
                <div className="input-field col s12">
                  <input type="text"
                         id="meeting_description"
                         name="meeting[description]"
                         value={meeting.description}
                         onChange={props.changeDescription} />
                  <label htmlFor="meeting_description" className="active">
                    Description
                  </label>
                </div>
              </div>

              <div className="row">
                <div className="col s12">
                  <div className="input-field">
                    <DateTimePicker id="meeting_start_time"
                                    onChange={props.changeDateTime} />
                  </div>
                </div>
              </div>

              <div className="row">
                <div className="input-field col s12">
                  <input type="number"
                         id="meeting_duration"
                         step="5"
                         value={meeting.duration}
                         onChange={props.changeDuration} />
                  <label htmlFor="meeting_duration" className="active">
                    Duration (min):
                  </label>
                </div>
              </div>

              <div className="row">
                <div className="input-field col s12">
                  <button className="btn primary"
                          id="add_meeting"
                          onClick={props.saveMeeting}>
                    <i className="material-icons left">add</i>
                    Add Meeting
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default NewMeeting;
