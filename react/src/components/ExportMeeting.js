import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import Flash from '../lib/Flash';
import ExportMeetingDialogBox from './ExportMeetingDialogBox';

class ExportMeeting extends Component {
  constructor(props) {
    super(props);

    this.baseUrl = `/api/v1/${this.props.accountType.toLowerCase()}_calendars`;
    this.addUrl = `/api/v1/meetings/${this.props.meeting.id}/` +
                  `${this.props.accountType.toLowerCase()}_calendars`;
    this.addText = `Add to ${this.props.accountType} Calendar`;

    this.onClick = this.onClick.bind(this);
    this.addClick = this.addClick.bind(this);
    this.cancelClick = this.cancelClick.bind(this);
    this.getCalendars = this.getCalendars.bind(this);
    this.changeCalendar = this.changeCalendar.bind(this);
  }

  onClick(event) {
    $('body').append('<div id="export-meeting-modal-container"></div>');
    this.getCalendars();
  }

  addClick(calendar, notify) {
    $.ajax({
      url: this.addUrl,
      method: 'POST',
      data: {
        calendar: calendar,
        notify: notify
      }
    })
    .done((data) => {
      Flash.success(data.message);
      this.cleanup();
    })
    .fail((response) => {
      data = response.responseJSON;
      Flash.error(data.message);
    });
  }

  cancelClick() {
    this.cleanup();
  }

  cleanup() {
    $('#export-meeting-modal').closeModal();
    ReactDOM.unmountComponentAtNode(
      document.getElementById('export-meeting-modal-container')
    );
  }

  getCalendars() {
    $.ajax({
      url: this.baseUrl,
      method: 'GET'
    })
    .done((data) => {
      ReactDOM.render(
        <ExportMeetingDialogBox meeting={this.props.meeting}
                                calendars={data.calendars}
                                addText={this.addText}
                                accountType={this.props.accountType}
                                addClick={this.addClick}
                                cancelClick={this.cancelClick} />,
        document.getElementById('export-meeting-modal-container')
      );
      $('#export-meeting-modal').openModal();
    })
    .fail((response) => {
      if(response.status == 401) {
        let data = response.responseJSON;
        Flash.error(data.message);
        return window.location.href = '/auth/google_oauth2';
      }

      Flash.error('There was a problem getting your calendars. ' +
                  'Please try again later.');
    });
  }

  changeCalendar(event) {
    this.setState({ selectedCalendar: event.target.value });
  }

  render() {
    return (
      <div className="export-meeting">
        <button className="waves-effect waves-light btn-flat"
                onClick={this.onClick}>
           {this.addText}
        </button>
      </div>
    );
  }
}

ExportMeeting.propTypes = {
  accountType: PropTypes.string.isRequired
}

export default ExportMeeting;
