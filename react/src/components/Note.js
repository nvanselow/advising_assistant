import React, { Component, PropTypes } from 'react';
import Confirmation from '../lib/Confirmation';
import Errors from './Errors';

class Note extends Component {
  constructor(props) {
    super(props);

    this.handleDelete = this.handleDelete.bind(this);
    this.deleteNoteConfirmed = this.deleteNoteConfirmed.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
  }

  handleDelete() {
    Confirmation.show({
                        header: 'Delete this note?',
                        okText: 'Yes, delete note',
                        okCallback: this.deleteNoteConfirmed
                      });
  }

  deleteNoteConfirmed() {
    this.props.onDelete(this.props.note);
  }

  handleEdit() {
    this.props.handleEdit(this.props.note);
  }

  render() {
    let note = this.props.note;
    return (
      <div className="note">
        <h4>{note.updated_at}</h4>
        <p>{note.body}</p>
        <button className="delete-note btn-floating danger"
                onClick={this.handleDelete}>
          <i className="material-icons">delete</i>
        </button>
        <button className="edit-note btn-floating"
                onClick={this.handleEdit} >
          <i className="material-icons">mode_edit</i>
        </button>
      </div>
    );
  }
}

Note.propTypes = {
  note: PropTypes.object.isRequired
}

export default Note;
