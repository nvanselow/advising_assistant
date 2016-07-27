import React, { Component, PropTypes } from 'react';
import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';
import Semester from './Semester';
import Course from './Course';

class GraduationPlan extends Component {
  constructor(props) {
    super(props);

    this.state = {
      planName: this.props.planName,
      newCourseName: '',
      semesters: [
        {
          id: 1,
          semester: 'Fall',
          year: 2016,
          courses: [
            {id: 1, name: 'PSY 325'},
            {id: 2, name: 'PSY 399'}
          ],
          remainingCourses: false
        },
        {
          id: 0,
          semester: 'Remaining Courses',
          year: 0,
          courses: [
            {id: 3, name: 'PSY 100'},
            {id: 4, name: 'PSY 220'},
            {id: 5, name: 'PSY 400'}
          ],
          remainingCourses: true
        }
      ]
    }

    this.updatePlanName = this.updatePlanName.bind(this);
    this.updateNewCourseName = this.updateNewCourseName.bind(this);
    this.addNewCourse = this.addNewCourse.bind(this);
    this.courseDropped = this.courseDropped.bind(this);
    this.deleteCourse = this.deleteCourse.bind(this);
    this.findSemester = this.findSemester.bind(this);
    this.findRemainingCoursesSemester = this.findRemainingCoursesSemester.bind(this);
    this.renderRemainingCourseSemesters = this.renderRemainingCourseSemesters.bind(this);
    this.renderSemesters = this.renderSemesters.bind(this);
  }

  componentDidMount() {
    $('.graduation-plan').on('courseDropped', this.courseDropped)
  }

  componentWillUnmount() {
    $('.graduationPlan').unbind();
  }

  updatePlanName(event) {
    this.setState({ planName: event.target.value });
  }

  updateNewCourseName(event) {
    this.setState({ newCourseName: event.target.value });
  }

  addNewCourse(event) {
    event.preventDefault();
    let semesters = this.state.semesters;
    let semester = this.findRemainingCoursesSemester(semesters);

    semester.courses.push({
      id: semester.courses.length + 3,
      name: this.state.newCourseName,
      semesterId: semester.id
    });

    this.setState({ semesters: semesters, newCourseName: '' });
  }

  deleteCourse(course) {
    let semesters = this.state.semesters;
    let semester = this.findSemester(course.semesterId);

    this.removeCourse(course, semester);

    this.setState({ semesters: semesters });
  }

  findRemainingCoursesSemester(semesters) {
    let remaininCourseSemesters = this.state.semesters.filter((semester) => {
      return semester.remainingCourses;
    });

    if(remaininCourseSemesters.length){
      return remaininCourseSemesters[0];
    } else {
      return null;
    }
  }

  findSemester(id) {
    let semesters = this.state.semesters.filter((semester) => {
      return semester.id == id;
    });

    if(semesters.length) {
      return semesters[0];
    } else {
      null;
    }
  }

  courseDropped(event, data) {
    let course = data.item;
    let previousSemesterId = course.semesterId;
    let newSemesterId = data.props.id;
    let semesters = this.state.semesters;

    console.log('original semesters', semesters[0]);

    let previousSemester = this.findSemester(previousSemesterId);
    let newSemester = this.findSemester(newSemesterId);

    previousSemester.courses = this.removeCourse(course, previousSemester);
    newSemester.courses = this.addCourse(course, newSemester);

    this.setState({ semesters: semesters });
  }

  removeCourse(course, semester) {
    return semester.courses.filter((currentCourse) => {
      return course.id != currentCourse.id;
    });
  }

  addCourse(course, semester) {
    course.semesterId = semester.id;
    semester.courses.push(course)
    return semester.courses;
  }

  mapSemesters(semesters) {
    return semesters.map((semester) => {
      return (
        <Semester key={semester.id}
                  id={semester.id}
                  semester={semester.semester}
                  year={semester.year}
                  courses={semester.courses}
                  remainingCourses={semester.remainingCourses}
                  onDeleteCourse={this.deleteCourse} />
      );
    });
  }

  renderRemainingCourseSemesters() {
    let semesters = this.state.semesters.filter((semester) => {
      return semester.remainingCourses;
    });
    return this.mapSemesters(semesters);
  }

  renderSemesters() {
    let semesters = this.state.semesters.filter((semester) => {
      return !semester.remainingCourses
    });
    return this.mapSemesters(semesters);
  }

  render() {
    return (
      <div className="graduation-plan">
        <div className="hide-on-small-only">
          <div className="row graduation-plan-name">
            <div className="col s12 m6 offset-m1 input-field">
              <input id="plan-name"
                     type="text"
                     value={this.state.planName}
                     onChange={this.updatePlanName} />
              <label htmlFor="plan-name" className="active">Plan Name</label>
            </div>
          </div>

          <form onSubmit={this.addNewCourse}>
            <div className="row center">
              <div className="col m5">
                <div className="row">
                  <div className="input-field col m6">
                    <input id="new-course-name"
                           type="text"
                           value={this.state.newCourseName}
                           onChange={this.updateNewCourseName}/>
                    <label htmlFor="new-course-name" className="active">
                      New Course Name
                    </label>
                  </div>
                  <div className="col m6">
                    <button type="submit"
                            className="btn standard add-course-button">
                      <i className="material-icons left">add</i>
                      Add Course
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </form>

          <div className="row">
            <div className="col m3">
              <div className="remaining-courses">
                {this.renderRemainingCourseSemesters()}
              </div>
            </div>

            <div className="col m9">
              <div className="row">
                {this.renderSemesters()}
              </div>
            </div>
          </div>
        </div>
        <div className="hide-on-med-and-up container">
          <p>
            Unfortunately, graduation plans cannot be created on small mobile
            devices.
          </p>
          <p>
            For the best experience, please view this page on your
            tablet, laptop, or desktop computer.
          </p>
        </div>
      </div>
    );
  }
}

GraduationPlan.propTypes = {
  planId: PropTypes.number.isRequired,
  planName: PropTypes.string.isRequired
}

export default DragDropContext(HTML5Backend)(GraduationPlan);
