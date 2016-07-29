import React, { Component } from 'react';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import Meeting from './Meeting';

class UpcomingMeetings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      meetings: [],
      showAllMeetings: false
    }

    this.getUpcomingMeetings = this.getUpcomingMeetings.bind(this);
    this.getAllMeetings = this.getAllMeetings.bind(this);
    this.receivedMeetings = this.receivedMeetings.bind(this);
    this.handleDeleteMeeting = this.handleDeleteMeeting.bind(this);
    this.renderMeetings = this.renderMeetings.bind(this);
  }

  componentDidMount() {
    this.getUpcomingMeetings();
  }

  getUpcomingMeetings() {
    $.ajax({
      url: '/api/v1/upcoming_meetings',
      method: 'GET'
    })
    .done(this.receivedMeetings);
    this.setState({ showAllMeetings: false });
  }

  getAllMeetings() {
    $.ajax({
      url: '/api/v1/all_meetings',
      method: 'GET'
    })
    .done(this.receivedMeetings);
    this.setState({ showAllMeetings: true });
  }

  receivedMeetings(data) {
    this.setState({ meetings: data.meetings });
  }

  handleDeleteMeeting(meeting) {
    let meetings = this.state.meetings.filter((currentMeeting) => {
      return meeting.id != currentMeeting.id;
    });

    this.setState({ meetings: meetings });
  }

  renderMeetings() {
    let meetings = this.state.meetings;

    if(!meetings.length){
      return <p className="no-meetings">You do not have any upcoming meetings!</p>
    } else {
      return meetings.map((meeting) => {
        return <Meeting key={meeting.id}
                        meeting={meeting}
                        advisee={meeting.advisee}
                        currentUrl="/advisees"
                        onDelete={this.handleDeleteMeeting} />
      });
    }
  }

  renderShowAllMeetingsButton() {
    if(this.state.showAllMeetings){
      return (
        <button key="1" className="btn-flat" onClick={this.getUpcomingMeetings}>
          Hide All Meetings
        </button>
      );
    } else {
      return (
        <button key="2" className="btn-flat" onClick={this.getAllMeetings}>
          Show All Meetings
        </button>
      );
    }
  }

  render() {
    return (
      <div className="upcoming-meetings">
        <h2 className="upcoming-meetings-header">Upcoming Meetings</h2>
        <ReactCSSTransitionGroup transitionName="generic"
                                 transitionEnterTimeout={500}
                                 transitionLeaveTimeout={300}
                                 transitionAppear={true}
                                 transitionAppearTimeout={500}>
          {this.renderMeetings()}
        </ReactCSSTransitionGroup>
        <div className="center">
          <ReactCSSTransitionGroup transitionName="generic"
                                   transitionEnterTimeout={500}
                                   transitionLeaveTimeout={300}
                                   transitionAppear={true}
                                   transitionAppearTimeout={500}>
            {this.renderShowAllMeetingsButton()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    );
  }
}

export default UpcomingMeetings
