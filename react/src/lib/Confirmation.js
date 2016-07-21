import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';

class ConfirmationDialogBox extends Component {
  constructor(props) {
    super(props);

    this.header = props.header;
    this.bodyText = props.bodyText;
    this.okText = props.okText;
    this.okCallback = props.okCallback;
    this.cancelText = props.cancelText;
    this.cancelCallback = props.cancelCallback;

    this.handleOkClick = this.handleOkClick.bind(this);
    this.handleCancelClick = this.handleCancelClick.bind(this);
  }

  componentDidMount(){
    $('#confirmation').openModal();
  }

  handleOkClick(event) {
    if(this.okCallback){
      this.okCallback(true);
    }
    this.cleanup();
  }

  handleCancelClick(event) {
    if(this.cancelCallback){
      this.cancelCallback(false);
    }
    this.cleanup();
  }

  cleanup() {
    ReactDOM.unmountComponentAtNode(document.getElementById('modal'));
  }

  render() {
    return (
      <div id="confirmation" className="modal">
        <div className="modal-content">
          <h4>{this.header}</h4>
          <p>{this.bodyText}</p>
        </div>
        <div className="modal-footer">
          <button className="cancel-btn modal-action modal-close waves-effect btn-flat"
                  onClick={this.handleCancelClick}>
            {this.cancelText}
          </button>
          <button className="ok-btn modal-action modal-close waves-effect btn"
                  onClick={this.handleOkClick}>
            {this.okText}
          </button>
        </div>
      </div>
    );
  }
}

ConfirmationDialogBox.propTypes = {
  header: PropTypes.string,
  body: PropTypes.string,
  okText: PropTypes.string,
  okCallback: PropTypes.func,
  cancelText: PropTypes.string,
  cancelCallback: PropTypes.func
}

class Confirmation {
  static show(options = {}) {
    if (!('header' in options)){
      options.header = 'Are you sure?';
    }
    if (!('bodyText' in options)){
      options.bodyText = 'This cannot be undone';
    }
    if (!('okText' in options)){
      options.okText = 'OK';
    }
    if (!('cancelText' in options)){
      options.cancelText = 'Cancel';
    }

    $('body').append('<div id="modal"></div>');

    ReactDOM.render(
      <ConfirmationDialogBox {...options} />,
      document.getElementById('modal')
    );
  }
}

export default Confirmation;
