import React, { Component } from 'react';
import Meeting from './Meeting';

class UpcomingMeetings extends Component {
  constructor(props) {
    super(props);

    this.state = {
      meetings: []
    }

    this.getUpcomingMeetings = this.getUpcomingMeetings.bind(this);
    this.getAllMeetings = this.getAllMeetings.bind(this);
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
    .done((data) => {
      this.setState({ meetings: data.meetings });
    });
  }

  getAllMeetings() {

  }

  renderMeetings() {
    let meetings = this.state.meetings;

    if(!meetings.length){
      return <p className="no-meetings">You do not have any upcoming meetings!</p>
    } else {
      return meetings.map((meeting) => {
        return <Meeting key={meeting.id}
                        meeting={meeting}
                        advisee={meeting.advisee} />
      });
    }
  }

  render() {
    return (
      <div className="upcoming-meetings">
        <h2 className="upcoming-meetings-header">Upcoming Meetings</h2>
        {this.renderMeetings()}
      </div>
    );
  }
}

export default UpcomingMeetings
