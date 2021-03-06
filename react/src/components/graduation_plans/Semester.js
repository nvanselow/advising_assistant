import React, { Component, PropTypes } from 'react';
import { ItemTypes } from './Constants';
import { DropTarget } from 'react-dnd';
import Course from './Course';

const semesterTarget = {
  drop(props, monitor) {
    $('.graduation-plan').trigger('courseDropped', {
      props: props,
      item: monitor.getItem()
    });
    addCourse(props, monitor.getItem());
  }
}

function addCourse(props, course) {
}

function collect(connect, monitor) {
  return {
    connectDropTarget: connect.dropTarget(),
    isOver: monitor.isOver()
  };
}

class Semester extends Component {
  constructor(props) {
    super(props);

    this.renderCourses = this.renderCourses.bind(this);
    this.calculateCredits = this.calculateCredits.bind(this);
  }

  renderCourses() {
    let { id, courses } = this.props;
    return this.props.courses.map((course) => {
      return (
        <Course key={course.id}
                id={course.id}
                name={course.name}
                credits={course.credits}
                semesterId={id}
                onDelete={this.props.onDeleteCourse}/>
      );
    });
  }

  calculateCredits() {
    let total = 0;
    this.props.courses.forEach((course) => {
      total += (course.credits / 10);
    });
    return total;
  }

  render() {
    const {
      semester,
      year,
      courses,
      remainingCourses,
      connectDropTarget,
      isOver
    } = this.props;

    let classes = 'col s4';
    if(remainingCourses) {
      classes = 'col s12';
    }

    let semesterClass = 'semester card blue-grey darken-2'
    if(isOver) {
      semesterClass = 'semester card blue-grey darken-1';
    }

    let semesterHeader = `${semester} ${year}`;
    if(remainingCourses) {
      semesterHeader = 'Remaining Courses';
    }

    let noClassesWarning = (
      <div className="no-classes-warning">
        <p>
          There are no classes remaining.
        </p>
        <p>
          Add some using the form above.
        </p>
      </div>
    );
    if(!remainingCourses || courses.length){
      noClassesWarning = null;
    }

    return connectDropTarget(
      <div className={classes}>
        <div className={semesterClass}>
          <div className="card-content white-text">
            <h5 className="card-title">
              <span>{semesterHeader}</span>
            </h5>
            <span className="credits">
              ({this.calculateCredits()} credits)
            </span>
            {noClassesWarning}
            {this.renderCourses()}
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
  courses: PropTypes.array.isRequired,
  remainingCourses: PropTypes.bool.isRequired,
  isOver: PropTypes.bool.isRequired
}

export default DropTarget(ItemTypes.COURSE, semesterTarget, collect)(Semester);
