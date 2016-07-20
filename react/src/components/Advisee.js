import React, { Component, PropTypes } from 'react';

class Advisee extends Component {
  render() {
    let advisee = this.props.advisee;
    let url = `/advisees/${advisee.id}`;
    return (
      <div className="advisee col s12 m4">
        <a href={url}>
          <div className="advisee-info">
            <h2>
              {advisee.first_name} {advisee.last_name}
            </h2>
            <h3>
              {advisee.graduation_semester}
              {advisee.graduation_year}
            </h3>
          </div>
        </a>
      </div>
    );
  }
}

Advisee.propTypes = {
  advisee: PropTypes.object.isRequired
}

export default Advisee;
