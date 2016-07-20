import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import AdviseeSearch from './components/AdviseeSearch';

// $(function() {
//   ReactDOM.render(
//     <h1>Boo yaa</h1>,
//     document.getElementById('app')
//   );
// });

$(function() {
  let adviseeSearch = document.getElementById('advisee-search')

  if(adviseeSearch){
    ReactDOM.render(
      <AdviseeSearch />,
      adviseeSearch
    );
  }
});
