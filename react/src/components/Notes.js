import React, { Component, PropTypes } from 'react';
import Flash from '../lib/Flash';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import Note from './Note';
import EditNote from './EditNote';
import Errors from './Errors';

class Notes extends Component {
  constructor(props) {
    super(props);

    let noteableType = this.props.noteableType;
    let noteableId = this.props.noteableId;
    let controller = this.props.controller;
    this.baseUrl = `/api/v1/${noteableType}/${noteableId}/${controller}`;
    this.controller = controller;

    this.state = {
      newNoteBody: '',
      newNoteErrors: [],
      notes: [],
      editingNoteId: null
    }

    this.getNotes = this.getNotes.bind(this);
    this.renderNotes = this.renderNotes.bind(this);
    this.saveNote = this.saveNote.bind(this);
    this.updateNoteBody = this.updateNoteBody.bind(this);
    this.noteCreated = this.noteCreated.bind(this);
    this.noteCreatedErrors = this.noteCreatedErrors.bind(this);
    this.deleteNote = this.deleteNote.bind(this);
    this.editNote = this.editNote.bind(this);
    this.updateNote = this.updateNote.bind(this);
    this.cancelUpdate = this.cancelUpdate.bind(this);
  }

  componentDidMount() {
    this.getNotes();
  }

  getNotes() {
    $.ajax({
      url: this.baseUrl,
      method: 'GET'
    }).done((data) => {
      this.setState({ notes: data.notes });
    });
  }

  renderNotes() {
    return this.state.notes.map((note) => {
      if(this.state.editingNoteId === note.id) {
        return (
          <EditNote key={note.id}
                    note={note}
                    onSave={this.updateNote}
                    onCancel={this.cancelUpdate}
                    {...this.props} />
        );
      } else {
        return (
          <Note key={note.id}
                note={note}
                onDelete={this.deleteNote}
                handleEdit={this.editNote} />
        );
      }
    });
  }

  updateNoteBody(event) {
    this.setState({ newNoteBody: event.target.value });
  }

  saveNote() {
    $.ajax({
      url: this.baseUrl,
      method: 'POST',
      data: {
        note: {
          body: this.state.newNoteBody
        }
      }
    })
    .done(this.noteCreated)
    .fail(this.noteCreatedErrors);
  }

  noteCreated(data) {
    let note = data.note;
    let notes = this.state.notes;
    notes.unshift(data.note);

    Flash.success(data.message);
    this.setState({ notes: notes, newNoteBody: '', newNoteErrors: [] });
  }

  noteCreatedErrors(response) {
    let data = response.responseJSON;
    Flash.error(data.message);
    this.setState({ newNoteErrors: data.errors });
  }

  deleteNote(note) {
    $.ajax({
      url: `/api/v1/${this.controller}/${note.id}`,
      method: 'DELETE'
    })
    .done((data) => {
      let notes = this.state.notes;

      notes = notes.filter((currentNote) => {
        return (note.id !== currentNote.id);
      });

      Flash.success('Note deleted!');
      this.setState({ notes: notes });
    })
    .fail((response) => {
      Flash.error('There was a problem deleting that note.');
    });
  }

  editNote(note) {
    this.setState({ editingNoteId: note.id });
  }

  updateNote(note) {
    let notes = this.state.notes;

    notes = notes.map((currentNote) => {
      if(currentNote.id == note.id){
        currentNote.body = note.body;
      }
      return currentNote;
    });

    this.setState({ notes: notes, editingNoteId: null });
  }

  cancelUpdate() {
    this.setState({ editingNoteId: null });
  }

  render() {
    return (
      <div className="notes-container">
        <div className="row">
          <Errors errors={this.state.newNoteErrors} />
          <div className="input-field add-note col s12">
            <textarea id="note_body"
                      name="note[body]"
                      className="materialize-textarea"
                      value={this.state.newNoteBody}
                      onChange={this.updateNoteBody} >
            </textarea>
            <label htmlFor="note_body">Note</label>
            <div className="input-field">
              <button id="add-note" onClick={this.saveNote} className="btn">
                <i className="material-icons left">add</i>
                Add Note
              </button>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col s12 notes">
            <ReactCSSTransitionGroup transitionName="generic"
                                     transitionEnterTimeout={500}
                                     transitionLeaveTimeout={300}
                                     transitionAppear={true}
                                     transitionAppearTimeout={500}>
              {this.renderNotes()}
            </ReactCSSTransitionGroup>
          </div>
        </div>
      </div>
    );
  }
}

Notes.propTypes = {
  noteableId: PropTypes.number.isRequired,
  noteableType: PropTypes.string.isRequired,
  controller: PropTypes.string.isRequired
}

export default Notes;
