import React, { Component, PropTypes } from 'react';

class Advisee extends Component {
  render() {
    let advisee = this.props.advisee;
    let url = `/advisees/${advisee.id}`;
    let altText = `Photo of ${advisee.first_name} ${advisee.last_name}`;
    let adviseeNameId = `advisee-name-${advisee.id}`;

    return (
      <div className="advisee col s12 m4">
        <a href={url}>
          <div className="advisee-info">
            <img src={advisee.photo_url} alt={altText} className="circle responsive-img" />
            <div id={adviseeNameId} className='advisee-name'>
              {advisee.first_name} {advisee.last_name}
            </div>
            <h3>
              {advisee.graduation_semester} {advisee.graduation_year}
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
