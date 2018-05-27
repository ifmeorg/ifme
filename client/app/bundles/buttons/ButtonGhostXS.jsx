import React from 'react';
import css from './button.scss';

class ButtonGhostXS extends React.Component {
   render() {    
      return (
         <button className = {css.buttonGhostXS}>
            {this.props.text}
         </button>
      );
   }
}
export default ButtonGhostXS;
