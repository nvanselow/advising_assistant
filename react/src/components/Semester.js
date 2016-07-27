import React, { Component, PropTypes } from 'react';
import { ItemTypes } from './Constants';
import { DropTarget } from 'react-dnd';
import Course from './Course';

const semesterTarget = {
  drop(props, monitor) {
    addCourse(props, monitor.getItem());
  }
}

function addCourse(props, course) {
  debugger;
}

function collect(connect, monitor) {
  return {
    connectDropTarget: connect.dropTarget(),
    isOver: monitor.isOver()
  };
}

class Semester extends Component {
  render() {
    const { connectDropTarget, isOver } = this.props;

    let classes = 'col s4 semester';
    if(isOver) {
      classes = classes + ' hovering';
    }

    return connectDropTarget(
      <div className={classes}>
        <div className="row text-center">
          <div className="col">
            <h5 className="text-center">
              {this.props.semester} {this.props.year}
            </h5>
          </div>
        </div>
        <div className="row">
          <div className="col">
            <Course id={1} name="PSY 325" />
            <Course id={2} name="PSY 399" />
          </div>
        </div>
      </div>
    );
  }
}

Semester.propTypes = {
  id: PropTypes.number.isRequired,
  semester: PropTypes.string.isRequired,
  year: PropTypes.number.isRequired,
  isOver: PropTypes.bool.isRequired
}

export default DropTarget(ItemTypes.COURSE, semesterTarget, collect)(Semester);
