import React, { Component, PropTypes } from 'react';
import { ItemTypes } from './Constants';
import { DragSource } from 'react-dnd';

const courseSource = {
  beginDrag(props) {
    return {
      id: props.id,
      name: props.name,
      credits: props.credits,
      semesterId: props.semesterId
    };
  }
};

function collect(connect, monitor) {
  return {
    connectDragSource: connect.dragSource(),
    isDragging: monitor.isDragging()
  };
}

class Course extends Component {
  constructor(props) {
    super(props);

    this.onDelete = this.onDelete.bind(this);
  }

  onDelete(event) {
    this.props.onDelete(this.props);
  }

  render() {
    const { credits, connectDragSource, isDragging } = this.props;
    let formatted_credits = credits / 10;

    return connectDragSource(
      <span className="chip course" style={{
        opacity: isDragging ? 0.5 : 1,
        cursor: 'move'
      }}>
        {this.props.name}
        <small> ({formatted_credits} credits)</small>
        <i className="close material-icons" onClick={this.onDelete}>
          close
        </i>
      </span>
    );
  }
}

Course.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  credits: PropTypes.number.isRequired,
  semesterId: PropTypes.number.isRequired,
  connectDragSource: PropTypes.func.isRequired,
  isDragging: PropTypes.bool.isRequired
}

export default DragSource(ItemTypes.COURSE, courseSource, collect)(Course);
