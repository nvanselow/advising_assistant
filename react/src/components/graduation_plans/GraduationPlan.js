import React, { Component, PropTypes } from 'react';
import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';
import Semester from './Semester';
import Course from './Course';
import Flash from '../../lib/Flash';

class GraduationPlan extends Component {
  constructor(props) {
    super(props);

    this.state = {
      planName: this.props.planName,
      newCourse: {
        name: '',
        credits: 3
      },
      semesters: []
    }

    this.getSemesters = this.getSemesters.bind(this);
    this.updatePlanName = this.updatePlanName.bind(this);
    this.updateNewCourseName = this.updateNewCourseName.bind(this);
    this.updateNewCourseCredits = this.updateNewCourseCredits.bind(this);
    this.addNewCourse = this.addNewCourse.bind(this);
    this.courseDropped = this.courseDropped.bind(this);
    this.deleteCourse = this.deleteCourse.bind(this);
    this.findSemester = this.findSemester.bind(this);
    this.findRemainingCoursesSemester = this.findRemainingCoursesSemester.bind(this);
    this.renderRemainingCourseSemesters = this.renderRemainingCourseSemesters.bind(this);
    this.renderSemesters = this.renderSemesters.bind(this);
  }

  componentDidMount() {
    $('.graduation-plan').on('courseDropped', this.courseDropped);
    this.getSemesters();
  }

  componentWillUnmount() {
    $('.graduationPlan').unbind();
  }

  getSemesters() {
    $.ajax({
      url: `/api/v1/graduation_plans/${this.props.planId}/semesters`,
      method: 'get'
    })
    .done((data) => {
      this.setState({ semesters: data.semesters });
    });
  }

  updatePlanName(event) {
    let newName = event.target.value;
    this.setState({ planName: newName });

    $.ajax({
      url: `/api/v1/graduation_plans/${this.props.planId}`,
      method: 'PUT',
      data: {
        graduation_plan: {
          name: newName
        }
      }
    })
    .fail((response) => {
      let data = response.responseJSON;
      Flash.error(data.message)
      data.errors.forEach((error) => {
        Flash.error(error);
      });
    });
  }

  updateNewCourseName(event) {
    let course = this.state.newCourse;
    course.name = event.target.value
    this.setState({ newCourse: course });
  }

  updateNewCourseCredits(event){
    let course = this.state.newCourse;
    course.credits = event.target.value;
    this.setState({ newCourse: course });
  }

  addNewCourse(event) {
    event.preventDefault();
    let semesters = this.state.semesters;
    let semester = this.findRemainingCoursesSemester(semesters);

    $.ajax({
      url: `/api/v1/semesters/${semester.id}/courses`,
      method: 'POST',
      data: {
        course: this.state.newCourse
      }
    })
    .done((data) => {
      Flash.success(data.message);
      semester.courses.push(data.course);
      this.setState({
        semesters: semesters,
        newCourse: { name: '', credits: 3 }
      });
    })
    .fail((response) => {
      let data = response.responseJSON;

      Flash.error(data.message);
      data.errors.forEach((error) => {
        Flash.error(error);
      });
    });
  }

  deleteCourse(course) {
    let semesters = this.state.semesters;
    let semester = this.findSemester(course.semesterId);
    this.removeCourse(course, semester);
    this.setState({ semesters: semesters });
    $.ajax({
      url: `/api/v1/courses/${course.id}`,
      method: 'DELETE'
    })
    .done((data) => {
      Flash.success(data.message);
    });
  }

  findRemainingCoursesSemester(semesters) {
    let remainingCourseSemesters = this.state.semesters.filter((semester) => {
      return semester.remaining_courses;
    });

    if(remainingCourseSemesters.length){
      return remainingCourseSemesters[0];
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

    let previousSemester = this.findSemester(previousSemesterId);
    let newSemester = this.findSemester(newSemesterId);

    $.ajax({
      url: `/api/v1/courses/${course.id}`,
      method: 'PUT',
      data: {
        new_semester_id: newSemester.id
      }
    })
    .done((data) => {
      this.removeCourse(course, previousSemester);
      this.addCourse(course, newSemester);
      this.setState({ semesters: semesters });
    })
    .fail((response) => {
      data = response.responseJSON;
      Flash.error(data.message);
      data.errors.forEach((error) => {
        Flash.error(error);
      });
    });
  }

  removeCourse(course, semester) {
    semester.courses = semester.courses.filter((currentCourse) => {
      return course.id != currentCourse.id;
    });
    return semester.courses;
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
                  remainingCourses={semester.remaining_courses}
                  onDeleteCourse={this.deleteCourse} />
      );
    });
  }

  renderAddCourseForm() {
    if(this.state.semesters.length == 0){
      return null;
    }

    return (
      <form onSubmit={this.addNewCourse}>
        <div className="row center">
          <div className="col m8">
            <div className="row">
              <div className="input-field col m5 l4">
                <input id="new-course-name"
                       type="text"
                       value={this.state.newCourse.name}
                       onChange={this.updateNewCourseName}/>
                <label htmlFor="new-course-name" className="active">
                  New Course Name
                </label>
              </div>
              <div className="input-field col m2 l2">
                <input id="new-course-credits"
                       type="number"
                       value={this.state.newCourse.credits}
                       onChange={this.updateNewCourseCredits}/>
                <label htmlFor="new-course-credits" className="active">
                  Credits
                </label>
              </div>
              <div className="col m5 l5 left-align">
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
    );
  }

  renderRemainingCourseSemesters() {
    let semesters = this.state.semesters.filter((semester) => {
      return semester.remaining_courses;
    });
    return this.mapSemesters(semesters);
  }

  renderSemesters() {
    let semesters = this.state.semesters.filter((semester) => {
      return !semester.remaining_courses
    });
    return this.mapSemesters(semesters);
  }

  render() {
    let noSemestersMessage = (
      <h5>
        There are no semesters for this graduation plan!!
      </h5>
    );


    if(this.state.semesters.length){
      noSemestersMessage = null;
    }

    let deletePlanModalId = `delete-plan-modal-${this.props.planId}`;

    return (
      <div className="graduation-plan">
        <div className="hide-on-small-only">
          <div className="row graduation-plan-name">
            <div className="col s12 m6 input-field">
              <input id="plan-name"
                     type="text"
                     value={this.state.planName}
                     onChange={this.updatePlanName} />
              <label htmlFor="plan-name" className="active">Plan Name</label>
            </div>
            <div className="col s12 offset-m3 m3">
              <button data-target={deletePlanModalId}
                      className="delete-plan btn danger modal-trigger">
                <i className="material-icons left">delete</i>
                Delete Plan
              </button>
            </div>
          </div>

          {noSemestersMessage}

          {this.renderAddCourseForm()}

          <div className="row">
            <div className="col m3">
              <div className="remaining-courses">
                {this.renderRemainingCourseSemesters()}
              </div>
            </div>

            <div className="col m9">
              <div className="row semesters">
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
