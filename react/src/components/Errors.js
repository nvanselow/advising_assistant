import React, { Component, PropTypes } from 'react';

class Errors extends Component {
  constructor(props){
    super(props);

    this.renderErrors = this.renderErrors.bind(this);
  }

  renderErrors() {
    let i = 0;

    return this.props.errors.map((error) => {
      i++;
      return (
        <li key={i}>
          {error}
        </li>
      );
    });
  }

  render() {
    if(this.props.errors && this.props.errors.length){
      return (
        <div className="errors">
          <h5>Errors:</h5>
          <ul>
            {this.renderErrors()}
          </ul>
        </div>
      );
    } else {
      return null;
    }

  }
}

export default Errors;
