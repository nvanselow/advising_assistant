import React, { Component, PropTypes } from 'react';
import Time from './Time';

class Meeting extends Component {
  render() {
    let meeting = this.props.meeting;
    let meetingDescription = 'Meeting';
    if(meeting.description && meeting.description.length){
      meetingDescription = meeting.description;
    }

    return (
      <div className="meeting card orange darken-4">
        <div className="card-content white-text">
          <span className="card-title">
            <Time dateTime={meeting.start_time} />
            <small>({meeting.duration}) minutes</small>
          </span>
          <p>
            {meeting.description}
          </p>
          <p>
            Starts in: <Time dateTime={meeting.start_time}
                             displayType="timeto" />
          </p>
        </div>
      </div>
    );
  }
}

Meeting.propTypes = {
  meeting: PropTypes.object.isRequired
}

export default Meeting;
