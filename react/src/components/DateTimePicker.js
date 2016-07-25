import React, { Component, PropTypes } from 'react';
import 'materialize-clockpicker/dist/js/materialize.clockpicker.js';
import moment from 'moment-timezone/builds/moment-timezone-with-data';
import Timezones from './Timezones';

class DateTimePicker extends Component {
  constructor(props) {
    super(props)

    this.state = {
      date: moment(),
      time: moment(),
      timezone: moment.tz.guess(),
      dateTime: moment()
    }

    if (!('dateLabel' in props)){
      this.dateLabel = 'Date';
    } else {
      this.dateLabel = props.dateLabel;
    }

    if (!('timeLabel' in props)){
      this.timeLabel = 'Time';
    } else {
      this.timeLabel = props.timeLabel;
    }

    this.dateId = `${this.props.id}_date`;
    this.timeId = `${this.props.id}_time`;
    this.timezoneId = `${this.props.id}_timezone`;
    this.jQueryDateId = `#${this.dateId}`;
    this.jQueryTimeId = `#${this.timeId}`;

    this.onDateChange = this.onDateChange.bind(this);
    this.onTimeChange = this.onTimeChange.bind(this);
    this.onTimezoneChange = this.onTimezoneChange.bind(this);
    this.onChange = this.onChange.bind(this);
  }

  componentDidMount() {
    if('initialValue' in this.props){
      let initialValue = moment(this.props.initialValue);
      this.setState({
        date: initialValue,
        time: initialValue,
        dateTime: initialValue
      });
    } else {
      this.setState({
        date: moment(),
        time: moment(),
        dateTime: moment()
      })
    }

    $(this.jQueryDateId).pickadate({
      selectMonths: true, // Creates a dropdown to control month
      selectYears: 5 // Creates a dropdown of 15 years to control year
    });

    $(this.jQueryTimeId).pickatime({
      autoclose: true
    });

    $(this.jQueryDateId).change(this.onDateChange);
    $(this.jQueryTimeId).change(this.onTimeChange);
  }

  componentWillUnmount() {
    $(this.jQueryDateId).unbind();
    $(this.jQueryTimeId).unbind();
  }

  onDateChange(event) {
    let timezone = this.state.timezone;
    let updatedDate = moment(event.target.value, 'DD MMMM, YYYY')
    let currentTime = this.state.time;

    this.setState({ date: updatedDate });

    this.onChange(this.combineDateAndTime(updatedDate,
                                          currentTime,
                                          timezone));
  }

  onTimeChange(event) {
    let timezone = this.state.timezone;
    let updatedTime = moment.tz(event.target.value,
                                'hh:mmA',
                                timezone)
    let currentDate = this.state.date;

    this.setState({ time: updatedTime });

    this.onChange(this.combineDateAndTime(currentDate,
                                          updatedTime,
                                          timezone));
  }

  onTimezoneChange(timezone) {
    let date = this.state.date;
    let time = this.state.time;
    this.setState({ timezone: timezone });
    this.onChange(this.combineDateAndTime(date, time, timezone));
  }

  combineDateAndTime(date, time, timezone) {
    if(!date || !time){
      return null;
    } else {
      time = moment.tz(time.format('YYYY-MM-DD HH:mm'), timezone);
      return date.format('YYYY-MM-DD') + time.format('THH:mm:SSZ');
    }
  }

  onChange(dateTime) {
    this.setState({ dateTime: moment(dateTime) });
    if(this.props.onChange){
      this.props.onChange(dateTime);
    }
  }

  render() {
    let dateTimeValue = this.state.dateTime.format();
    let dateValue = this.state.date.format('D MMMM, YYYY');
    let timeValue = this.state.time.format('hh:mmA');

    return (
      <div className="date-time-picker">
        <input type="hidden" name={this.props.name} value={dateTimeValue} />
        <div className="input-field">
          <label htmlFor={this.dateId}>
            {this.dateLabel}
          </label>
          <input type="date"
                 className="datepicker"
                 id={this.dateId}
                 value={dateValue}
                 onChange={this.onDateChange} />
        </div>
        <div className="input-field">
          <label htmlFor={this.timeId} className="active">
            {this.timeLabel}
          </label>
          <input type="time"
                 className="timepicker"
                 id={this.timeId}
                 value={timeValue}
                 onChange={this.onTimeChange} />
        </div>

        <div className="input-field">
          <Timezones id="meeting_timezone"
                     label="Timezone"
                     onChange={this.onTimezoneChange} />
        </div>
      </div>
    );
  }
}

DateTimePicker.propTypes = {
  onChange: PropTypes.func,
  dateLabel: PropTypes.string,
  timeLabel: PropTypes.string
}

export default DateTimePicker;
