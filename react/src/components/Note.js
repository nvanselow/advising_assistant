import React, { Component, PropTypes } from 'react';

class Note extends Component {
  render() {
    let note = this.props.note;

    return (
      <div className="note">
      <h4>{note.updated_at}</h4>
        <p>{note.body}</p>
      </div>
    );
  }
}

Note.propTypes = {
  note: PropTypes.object.isRequired
}

export default Note;
