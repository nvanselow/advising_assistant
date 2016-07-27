import React, { Component, PropTypes } from 'react';
import { ItemTypes } from './Constants';
import { DragSource } from 'react-dnd';

const courseSource = {
  beginDrag(props) {
    return {
      id: props.id,
      name: props.name,
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
  }

  render() {
    const { connectDragSource, isDragging } = this.props;

    return connectDragSource(
      <span className="chip course" style={{
        opacity: isDragging ? 0.5 : 1,
        cursor: 'move'
      }}>
        {this.props.name}
        <i className="close material-icons">close</i>
      </span>
    );
  }
}

Course.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  semesterId: PropTypes.number.isRequired,
  connectDragSource: PropTypes.func.isRequired,
  isDragging: PropTypes.bool.isRequired
}

export default DragSource(ItemTypes.COURSE, courseSource, collect)(Course);
