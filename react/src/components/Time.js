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

    this.transformTime = this.transformTime.bind(this);
  }

  transformTime() {
    let dateTime = moment(this.props.dateTime);
    if (this.displayType == 'timeago') {
      return dateTime.tz(moment.tz.guess()).fromNow();
    } else if (this.displayType = 'timeto') {
      return dateTime.tz(moment.tz.guess()).toNow();
    } else {
      return dateTime.tz(moment.tz.guess()).format('MMM Qo, YYYY h:mm a');
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
  displayType: PropTypes.string
}

export default Time;
