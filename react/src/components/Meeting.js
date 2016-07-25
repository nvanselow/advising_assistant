import React, { Component, PropTypes } from 'react';
import Time from './Time';
import Flash from '../lib/Flash';
import ExportOptions from './ExportOptions';

class Meeting extends Component {
  constructor(props) {
    super(props);

    this.handleDelete = this.handleDelete.bind(this);
  }

  handleDelete() {
    $.ajax({
      url: `/api/v1/meetings/${this.props.meeting.id}`,
      method: 'DELETE'
    })
    .done((data) => {
      Flash.success('Meeting deleted!')
      this.props.onDelete(this.props.meeting);
    });
  }

  render() {
    let meeting = this.props.meeting;
    let meetingDescription = 'Meeting';
    let meetingUrl = `/meetings/${meeting.id}`;

    if(meeting.description && meeting.description.length){
      meetingDescription = meeting.description;
    }

    return (
      <div className="meeting card orange darken-4">
        <div className="card-content white-text">
          <span className="card-title">
            <a href={meetingUrl} className="meeting-details-link">
              <Time dateTime={meeting.start_time} />
              <small> ({meeting.duration} minutes)</small>
            </a>
          </span>
          <p>
            <Time dateTime={meeting.start_time} displayType="timeago" />
          </p>
          <p className="meeting-description">
            {meeting.description}
          </p>
        </div>
        <div className="card-action">
          <button className="delete-meeting btn-floating danger"
                  onClick={this.handleDelete}>
            <i className="material-icons">delete</i>
          </button>
          <ExportOptions meeting={this.props.meeting} />
        </div>
      </div>
    );
  }
}

Meeting.propTypes = {
  meeting: PropTypes.object.isRequired
}

export default Meeting;
