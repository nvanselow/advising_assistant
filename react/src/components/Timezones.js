import React, { Component } from 'react';
import moment from 'moment-timezone/builds/moment-timezone-with-data';

class Timezones extends Component {
  constructor(props) {
    super(props);

    this.timezones = moment.tz.names();
    this.timezones.unshift(moment.tz.guess());

    this.timezoneOptions = this.timezoneOptions.bind(this);
    this.onChange = this.onChange.bind(this);
  }

  timezoneOptions() {
    let i = 0;
    return this.timezones.map((timezone) => {
      i++;
      return (
        <option key={i} value={timezone}>
          {timezone}
        </option>
      );
    });
  }

  onChange(event) {
    this.props.onChange(event.target.value);
  }

  render() {
    return (
      <div className="timezone-select">
        <select id={this.props.id} onChange={this.onChange} placeholder="Timezone">
          {this.timezoneOptions()}
        </select>
      </div>
    );
  }
}

export default Timezones;
