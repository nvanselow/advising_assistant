import React, { Component, PropTypes } from 'react';
import moment from 'moment-timezone/builds/moment-timezone-with-data';

class Time extends Component {
  constructor(props) {
    super(props);

    if (!('displayType' in props)){
      this.displayType = 'standard';
    } else {
      this.displayType = props.displayType;
    }

    if(!('format' in props)){
      this.format = 'MMM D, YYYY h:mm a';
    } else {
      this.format = props.format;
    }

    this.transformTime = this.transformTime.bind(this);
  }

  transformTime() {
    let dateTime = moment(this.props.dateTime);

    if(this.props.timezone && this.props.timezone.length > 0){
      dateTime = moment.tz(this.props.dateTime, this.props.timezone);
    }

    if (this.displayType == 'timeago') {
      return dateTime.fromNow();
    } else {
      return dateTime.format(this.format);
    }
  }

  render() {
    return (
      <span>{this.transformTime()}</span>
    );
  }
}

Time.propTypes = {
  dateTime: PropTypes.string.isRequired,
  displayType: PropTypes.string,
  format: PropTypes.string
}

export default Time;
