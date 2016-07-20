import React, { Component } from 'react';

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
        <li key={advisee.id}>
          {advisee.first_name} {advisee.last_name}
        </li>
      );
    });
  }

  render() {
    return (
      <div id="advisee-search" className="search">
        <div className="input-field">
          <i className="material-icons prefix">search</i>
          <input type="text"
                 id="search"
                 name="search"
                 value={this.state.searchQuery}
                 onChange={this.updateSearchQuery} />
        </div>

        <div className="advisees">
          <ul>
            {this.renderAdvisees()}
          </ul>
        </div>
      </div>
    );
  }
}

export default AdviseeSearch;
