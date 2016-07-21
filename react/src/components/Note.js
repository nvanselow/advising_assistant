import React, { Component, PropTypes } from 'react';
import Confirmation from '../lib/Confirmation';

class Note extends Component {
  constructor(props) {
    super(props);

    this.handleDelete = this.handleDelete.bind(this);
    this.deleteNoteConfirmed = this.deleteNoteConfirmed.bind(this);
  }

  handleDelete() {
    Confirmation.show({
                        header: 'Delete this note?',
                        okText: 'Yes, Delete Note',
                        okCallback: this.deleteNoteConfirmed
                      });
  }

  deleteNoteConfirmed() {
    this.props.onDelete(this.props.note);
  }

  render() {
    let note = this.props.note;

    return (
      <div className="note">
        <h4>{note.updated_at}</h4>
        <p>{note.body}</p>
        <button className="btn-floating danger" onClick={this.handleDelete}>
          <i className="material-icons">delete</i>
        </button>
      </div>
    );
  }
}

Note.propTypes = {
  note: PropTypes.object.isRequired
}

export default Note;
