import React, { Component, PropTypes } from 'react';
import Confirmation from '../lib/Confirmation';
import Errors from './Errors';
import Time from './Time';

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
      <div className="note card blue-grey darken-1">
        <div className="card-content white-text">
          <span className="card-title">
            Note: <small>
            (updated <Time dateTime={note.updated_at} displayType="timeago"/>)
          </small>
          </span>
          <p>{note.body}</p>
        </div>
        <div className="card-action">
          <button className="delete-note btn-floating danger"
                  onClick={this.handleDelete}>
            <i className="material-icons">delete</i>
          </button>
          <button className="edit-note btn-floating"
                  onClick={this.handleEdit} >
            <i className="material-icons">mode_edit</i>
          </button>
        </div>
      </div>
    );
  }
}

Note.propTypes = {
  note: PropTypes.object.isRequired
}

export default Note;
