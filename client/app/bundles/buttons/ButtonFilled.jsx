import React from 'react';
import css from './button.scss';

class ButtonFilled extends React.Component {
   render() {
       
       
      return (
          <div>
         <button className = {css.buttonFilled}>
            Learn More
         </button>
          </div>
      );
   }
}
export default ButtonFilled;
