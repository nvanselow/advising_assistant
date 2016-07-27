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
      semesters: []
    }

    this.updatePlanName = this.updatePlanName.bind(this);
  }

  updatePlanName(event) {
    this.setState({ planName: event.target.value });
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

          <div className="row">
            <div className="col m3">
              <div className="remaining-courses">
                <div className="row">
                  <div className="col s12">
                    <h5>Remaining Courses</h5>
                  </div>
                </div>
                <div className="row">
                  <div className="col s12">
                    <Course id={3} name="PSY 100" />
                    <Course id={4} name="PSY 220" />
                    <Course id={5} name="PSY 400" />
                  </div>
                </div>
              </div>
            </div>

            <div className="col m9">
              <div className="row">
                <Semester id={1} semester="Fall" year={2016} />
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
