import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import AdviseeSearch from './components/AdviseeSearch';
import Notes from './components/Notes';

$(function() {
  let adviseeSearch = document.getElementById('advisee-search');

  if(adviseeSearch){
    ReactDOM.render(
      <AdviseeSearch />,
      adviseeSearch
    );
  }

  let adviseeNotes = document.getElementById('advisee-notes');

  if(adviseeNotes){
    let adviseeId = $('#advisee-data').data('id');

    ReactDOM.render(
      <Notes noteableType="advisees"
             noteableId={adviseeId}
             controller="advisee_notes" />,
      adviseeNotes
    );
  }
});
