import React, { Component } from 'react';
import moment from 'moment-timezone/builds/moment-timezone-with-data';

class Timezones extends Component {
  constructor(props) {
    super(props);

    this.timezones = moment.tz.names();
    this.timezones.unshift(moment.tz.guess());

    this.jQueryId = `#${props.id}`;

    this.timezoneOptions = this.timezoneOptions.bind(this);
    this.onChange = this.onChange.bind(this);
  }

  componentDidMount() {
    $(this.jQueryId).change(this.onChange);
  }

  componentWillUnmount() {
    $(this.jQueryId).unbind();
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
      <div className="timezone-select" id={this.props.id}>
        <select>
          {this.timezoneOptions()}
        </select>
      </div>
    );
  }
}

export default Timezones;
