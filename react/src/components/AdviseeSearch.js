import React, { Component } from 'react';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group';
import Advisee from './Advisee';
import Loader from './Loader';

class AdviseeSearch extends Component {
  constructor(props) {
    super(props)

    this.state = {
      originalAdvisees: [],
      advisees: [],
      searchQuery: '',
      loading: false
    }

    this.searchAdvisees = this.searchAdvisees.bind(this);
    this.updateSearchQuery = this.updateSearchQuery.bind(this);
    this.noAdviseesMessage = this.noAdviseesMessage.bind(this);
  }

  componentDidMount() {
    this.setState({ loading: true });
    this.searchAdvisees();
  }

  updateSearchQuery(event) {
    this.setState({ searchQuery: event.target.value });
    this.searchAdvisees(event.target.value);
  }

  searchAdvisees(searchQuery) {
    let url = '/api/v1/search_advisees';
    let noSearch = true;

    if(searchQuery && searchQuery.length > 0){
      url = url + '?search=' + searchQuery;
      noSearch = false;
    }

    $.ajax({
      url: url,
      method: 'GET'
    }).done((data) => {
      if(noSearch){
        this.setState({ originalAdvisees: data.advisees});
      }
      this.setState({ advisees: data.advisees });
    })
    .always(() => {
      this.setState({ loading: false });
    });
  }

  renderAdvisees() {
    return this.state.advisees.map((advisee) => {
      return (
        <Advisee key={advisee.id} advisee={advisee} />
      );
    });
  }

  noAdviseesMessage() {
    if(this.state.originalAdvisees.length == 0){
      return (
        <div className="no-advisees card blue-grey darken-1">
          <div className="card-content white-text center-align">
            <h5>
              You have not created any advisees. Add one to get started.
            </h5>

          </div>
          <div className="card-action">
            <a href="/advisees/new">
              <i className="material-icons left">add</i>
              Add Advisee
            </a>
          </div>
        </div>
      );
    } else {
      return null;
    }
  }

  render() {
    let advisees = this.renderAdvisees();

    return (
      <Loader active={this.state.loading}>
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

          {this.noAdviseesMessage()}

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
      </Loader>
    );
  }
}

export default AdviseeSearch;
