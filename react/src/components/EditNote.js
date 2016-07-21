import React, { Component } from 'react';
import Errors from './Errors';
import Flash from '../lib/Flash';

class EditNote extends Component {
  constructor(props) {
    super(props);

    this.state = {
      note: Object.assign({}, props.note),
      noteErrors: []
    }

    this.updateBody = this.updateBody.bind(this);
    this.saveNote = this.saveNote.bind(this);
    this.cancelEdits = this.cancelEdits.bind(this);
  }

  updateBody(event) {
    let note = this.state.note;
    note.body = event.target.value;
    this.setState({ note: note });
  }

  saveNote(event) {
    let controller = this.props.controller;

    $.ajax({
      url: `/api/v1/${controller}/${this.state.note.id}`,
      method: 'PUT',
      data: {
        note: this.state.note
      }
    })
    .done((data) => {
      Flash.success('Note updated!');
      this.props.onSave(this.state.note);
    })
    .fail((response) => {
      Flash.error('There was a problem updating the note');
      this.setState({ noteErrors: response.responseJSON.errors });
    });

  }

  cancelEdits(event) {
    this.props.onCancel();
  }

  render() {
    return (
      <div className="note editing">
        <Errors errors={this.state.noteErrors} />
        <div className="row">
          <div className="input-field add-note col s12">
            <textarea id="edit_note_body"
                      name="note[body]"
                      className="materialize-textarea"
                      value={this.state.note.body}
                      onChange={this.updateBody} >
            </textarea>
            <label htmlFor="note_body" className="active">Note</label>
          </div>
        </div>
        <div className="row">
          <div className="col s6 input-field">
            <button id="save-note" onClick={this.saveNote} className="btn">
              Save
            </button>
          </div>
          <div className="col s6 input-field">
            <button id="cancel_edit_note"
                    onClick={this.cancelEdits}
                    className="btn-flat">
              Cancel
            </button>
          </div>
        </div>
      </div>
    );
  }
}

export default EditNote;
