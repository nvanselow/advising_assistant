import React, { Component, PropTypes } from 'react';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import Flash from '../lib/Flash';
import Errors from './Errors';
import moment from 'moment-timezone/builds/moment-timezone-with-data';
import DateTimePicker from './DateTimePicker';
import Meeting from './Meeting';

class Meetings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      newMeeting: this.resetMeeting(),
      newMeetingErrors: [],
      meetings: []
    }

    this.getMeetings = this.getMeetings.bind(this);
    this.changeDescription = this.changeDescription.bind(this);
    this.changeDateTime = this.changeDateTime.bind(this);
    this.changeDuration = this.changeDuration.bind(this);
    this.saveMeeting = this.saveMeeting.bind(this);
    this.renderMeetings = this.renderMeetings.bind(this);
    this.onMeetingDelete = this.onMeetingDelete.bind(this);
  }

  componentDidMount() {
    this.getMeetings();
  }

  getMeetings() {
    $.ajax({
      url: `/api/v1/advisees/${this.props.adviseeId}/meetings`,
      method: 'GET'
    })
    .done((data) => {
      this.setState({ meetings: data.meetings });
    });
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

  renderMeetings() {
    return this.state.meetings.map((meeting) => {
      return <Meeting key={meeting.id}
                      meeting={meeting}
                      onDelete={this.onMeetingDelete} />;
    });
  }

  saveMeeting(event) {
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
      let meeting = this.state.newMeeting;
      meeting.description = '';
      this.setState({ meetings: meetings,
                      newMeeting: meeting,
                      newMeetingErrors: [] });
      Flash.success('Meeting created!');
    })
    .fail((response) => {
      let data = response.responseJSON;
      Flash.error(data.message);
      this.setState({ newMeetingErrors: data.errors });
    });
  }

  onMeetingDelete(meeting) {
    let meetings = this.state.meetings;

    meetings = meetings.filter((currentMeeting) => {
      return meeting.id !== currentMeeting.id;
    });

    this.setState({ meetings: meetings });
  }

  render() {
    let meeting = this.state.newMeeting;

    return (
      <div className="meetings-container">
        <Errors errors={this.state.newMeetingErrors} />
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
                           onChange={this.changeDescription} />
                    <label htmlFor="meeting_description">Description</label>
                  </div>
                </div>

                <div className="row">
                  <div className="col s12">
                    <div className="input-field">
                      <DateTimePicker id="meeting_start_time"
                                      onChange={this.changeDateTime} />
                    </div>
                  </div>
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

                <div className="row">
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
            </div>
          </div>
        </div>
        <div className="meetings">
          <ReactCSSTransitionGroup transitionName="generic"
                                   transitionEnterTimeout={500}
                                   transitionLeaveTimeout={300}
                                   transitionAppear={true}
                                   transitionAppearTimeout={500}>
            {this.renderMeetings()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    );
  }
}

export default Meetings;
