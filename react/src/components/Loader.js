import React, { Component, PropTypes } from 'react';

class Loader extends Component {
  render(props) {
    if(this.props.active){
      return (
        <div className="loader center">
          <div className="progress">
            <div className="indeterminate"></div>
          </div>
          <h5>Loading...</h5>
        </div>
      );
    } else {
      return (
        <div>
          {this.props.children}
        </div>
      );
    }
  }
}

Loader.propTypes = {
  active: PropTypes.bool.isRequired
}

export default Loader;
