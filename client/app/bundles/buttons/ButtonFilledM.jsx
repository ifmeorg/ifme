import React from 'react';
import css from './button.scss';


class ButtonFilledM extends React.Component {
   render() {
       
       
      return (
         <button className = {css.buttonFilledM}>
            {this.props.text}
         </button>
      );
   }
}
export default ButtonFilledM;
