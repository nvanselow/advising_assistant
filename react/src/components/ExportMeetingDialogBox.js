import React, { Component, PropTypes } from 'react';

class ExportMeetingDialogBox extends Component {
  constructor(props) {
    super(props);

    this.state = {
      selectedCalendar: this.props.calendars[0],
      notify: true
    }

    this.calendarOptions = this.calendarOptions.bind(this);
    this.onChange = this.onChange.bind(this);
    this.onNotifyChange = this.onNotifyChange.bind(this);
    this.addClick = this.addClick.bind(this);
    this.cancelClick = this.cancelClick.bind(this);
  }

  calendarOptions() {
    return this.props.calendars.map((calendar) => {
      return (
        <option key={calendar.id} value={calendar.id}>
          {calendar.name}
        </option>
      );
    });
  }

  onChange(event) {
    this.setState({ selectedCalendar: event.target.value });
  }

  onNotifyChange(event) {
    this.setState({ notify: event.target.checked });
  }

  addClick(event) {
    this.props.addClick(this.state.selectedCalendar, this.state.notify);
  }

  cancelClick(event) {
    this.props.cancelClick();
  }

  render() {
    return (
      <div id="export-meeting-modal" className="modal">
        <div className="modal-content">
          <h4>{this.props.addText}</h4>
          <p>Please select a calendar.</p>
          <div className="input-field col s12">
            <label className="active">Calendars</label>
            <select className="browser-default"
                    value={this.state.selectedCalendar}
                    onChange={this.onChange} >
              {this.calendarOptions()}
            </select>
          </div>
          <p>
            <input type="checkbox"
                   className="filled-in"
                   id="notify-checkbox"
                   checked={this.state.notify}
                   onChange={this.onNotifyChange} />
            <label htmlFor="notify-checkbox">Invite advisee</label>
          </p>
          <p>
            This meeting will be added to the calendar you selected above.
          </p>
        </div>
        <div className="modal-footer">
          <a href="#!" className="modal-action waves-effect waves-light"
                       onClick={this.addClick}>
            Export Meeting
          </a>
          <a href="#!" className="modal-action waves-effect waves-light btn-flat" onClick={this.cancelClick}>Cancel</a>
        </div>
      </div>
    );
  }
}

ExportMeetingDialogBox.propTypes = {
  calendars: PropTypes.array.isRequired,
  addText: PropTypes.string.isRequired
}

export default ExportMeetingDialogBox;
