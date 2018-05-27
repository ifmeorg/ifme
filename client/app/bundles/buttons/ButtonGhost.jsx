import React from 'react';
import css from './button.scss';

class ButtonGhost extends React.Component {
   render() {
      return (
         <button className = {css.buttonGhost}>
            {this.props.text}
         </button>
      );
   }
}
export default ButtonGhost;
