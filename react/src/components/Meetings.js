import React, { Component, PropTypes } from 'react';

class Meetings extends Component {
  constructor(props) {
    super(props);

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
              <button className="btn">
                <i className="material-icons left">add</i>
                Add Meeting
              </button>
            </div>
            <div className="input-field">
              <label htmlFor="meeting_start_time">Start Time</label>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Meetings;
