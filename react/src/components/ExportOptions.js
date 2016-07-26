import React, { Component } from 'react';
import ExportMeeting from './ExportMeeting';

class ExportOptions extends Component {
  componentDidMount() {
    $('.dropdown-button').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrain_width: false, // Does not change width of dropdown to that of the activator
      hover: true, // Activate on hover
      gutter: 0, // Spacing from edge
      belowOrigin: false, // Displays dropdown below the button
      alignment: 'left' // Displays dropdown with edge aligned to the left of button
    });
  }

  render() {
    let id = `calendar-export-options-${this.props.meeting.id}`;

    return (
      <div className="calendar-export-options right">
        <a className='dropdown-button btn primary' href='#' data-activates={id}>
          Add to Calendar
        </a>

        <ul id={id} className='dropdown-content'>
          <li>
            <ExportMeeting meeting={this.props.meeting} accountType="Google" />
            <ExportMeeting meeting={this.props.meeting} accountType="Microsoft" />
          </li>
        </ul>
      </div>
    );
  }
}

export default ExportOptions;
