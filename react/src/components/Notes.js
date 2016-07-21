import React, { Component, PropTypes } from 'react';
import Flash from '../lib/Flash';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import Note from './Note';
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
    }

    this.getNotes = this.getNotes.bind(this);
    this.renderNotes = this.renderNotes.bind(this);
    this.saveNote = this.saveNote.bind(this);
    this.updateNoteBody = this.updateNoteBody.bind(this);
    this.noteCreated = this.noteCreated.bind(this);
    this.noteCreatedErrors = this.noteCreatedErrors.bind(this);
    this.deleteNote = this.deleteNote.bind(this);
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
      return (
        <Note key={note.id} note={note} onDelete={this.deleteNote} />
      );
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

  noteDelete() {
    Flash.success('Note deleted!')
  }

  render() {
    return (
      <div className="notes-container">
        <div className="row">
          <Errors errors={this.state.newNoteErrors} />
          <div className="input-field add-note col s12 m4">
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

          <div className="col s12 offset-m1 m7 notes">
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
