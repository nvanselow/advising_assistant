import React, { Component, PropTypes } from 'react';
import Time from './Time';
import Flash from '../lib/Flash';
import ExportOptions from './ExportOptions';
import Confirmation from '../lib/Confirmation';

class Meeting extends Component {
  constructor(props) {
    super(props);

    this.handleDelete = this.handleDelete.bind(this);
    this.deleteMeetingConfirmed = this.deleteMeetingConfirmed.bind(this);
    this.advisee = this.advisee.bind(this);
  }

  handleDelete() {
    Confirmation.show({
                        header: 'Delete this meeting?',
                        okText: 'Yes, delete meeting',
                        okCallback: this.deleteMeetingConfirmed
                      });
  }

  deleteMeetingConfirmed() {
    $.ajax({
      url: `/api/v1/meetings/${this.props.meeting.id}`,
      method: 'DELETE'
    })
    .done((data) => {
      Flash.success('Meeting deleted!')
      this.props.onDelete(this.props.meeting);
    });
  }

  advisee() {
    let advisee = this.props.advisee;
    if(advisee){
      let adviseeUrl = `/advisees/${advisee.id}`;

      return (
        <p>
          <span>Meeting with: </span>
          <a href={adviseeUrl} className='advisee-link'>
            {advisee.full_name}
          </a>
        </p>
      );
    } else {
      return null;
    }
  }

  render() {
    let meeting = this.props.meeting;
    let meetingDescription = 'Meeting';
    let meetingUrl = `/meetings/${meeting.id}`;

    if(meeting.description && meeting.description.length){
      meetingDescription = meeting.description;
    }

    return (
      <div className="meeting card cyan darken-3">
        <div className="card-content white-text">
          <span className="card-title">
            <a href={meetingUrl} className="meeting-details-link">
              <Time dateTime={meeting.start_time} />
            </a>
            <small> ({meeting.duration} minutes)</small>
          </span>
          {this.advisee()}
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
  meeting: PropTypes.object.isRequired,
  advisee: PropTypes.object
}

export default Meeting;
