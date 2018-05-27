import React from 'react';
import css from './button.scss';

class ButtonGhostM extends React.Component {
   render() {    
      return (
         <button className = {css.buttonGhostM}>
            {this.props.text}
         </button>
      );
   }
}
export default ButtonGhostM;
