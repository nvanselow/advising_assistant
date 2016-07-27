import React, { Component, PropTypes } from 'react';
import { ItemTypes } from './Constants';
import { DragSource } from 'react-dnd';

class Course extends Component {
  render() {
    return (
      <span className="chip course">
        {this.props.name}
        <i className="close material-icons">close</i>
      </span>
    );
  }
}

Course.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired
}

export default Course;
