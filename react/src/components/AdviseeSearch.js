import React, { Component } from 'react';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import Advisee from './Advisee';

class AdviseeSearch extends Component {
  constructor(props) {
    super(props)

    this.state = {
      advisees: [],
      searchQuery: ''
    }

    this.searchAdvisees = this.searchAdvisees.bind(this);
    this.updateSearchQuery = this.updateSearchQuery.bind(this);
  }

  componentDidMount() {
    this.searchAdvisees();
  }

  updateSearchQuery(event) {
    this.setState({ searchQuery: event.target.value });
    this.searchAdvisees(event.target.value);
  }

  searchAdvisees(searchQuery) {
    let url = '/api/v1/search_advisees';
    if(searchQuery && searchQuery.length > 0){
      url = url + '?search=' + searchQuery;
    }

    $.ajax({
      url: url,
      method: 'GET'
    }).done((data) => {
      this.setState({ advisees: data.advisees });
    });
  }

  renderAdvisees() {
    return this.state.advisees.map((advisee) => {
      return (
        <Advisee key={advisee.id} advisee={advisee} />
      );
    });
  }

  render() {
    let advisees = this.renderAdvisees();

    return (
      <div id="advisee-search" className="search">
        <div className="input-field">
          <i className="material-icons prefix">search</i>
          <input type="text"
                 id="search"
                 name="search"
                 value={this.state.searchQuery}
                 onChange={this.updateSearchQuery}
                 autoComplete="off" />
        </div>

        <div className="advisees row">
          <ReactCSSTransitionGroup transitionName="advisee"
                                   transitionEnterTimeout={500}
                                   transitionLeaveTimeout={300}
                                   transitionAppear={true}
                                   transitionAppearTimeout={500}>
            {advisees}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    );
  }
}

export default AdviseeSearch;
