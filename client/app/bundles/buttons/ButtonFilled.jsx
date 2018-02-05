import React from 'react';
import css from './button.scss';

class ButtonFilled extends React.Component {
   render() {
       
       
      return (
         <button className = {css.buttonFilled}>
            {this.props.text}
         </button>
      );
   }
}
export default ButtonFilled;
