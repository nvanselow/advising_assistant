import React from 'react';
import Time from './Time';

let MeetingTime = (props) => {
  return (
    <div className="meeting-time">
      <Time dateTime={props.startTime} format="MMM D, YYYY" />
      <span> from </span>
      <Time dateTime={props.startTime} format="h:mm a" />
      <span> to </span>
      <Time dateTime={props.endTime} format="h:mm a" />
    </div>
  );
}

export default MeetingTime;
