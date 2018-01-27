import React from 'react';
import css from './button.scss';


class ButtonGhost extends React.Component {
   render() {
       
       
      return (
          <div>
         <button className = {css.buttonGhost}>
            Join
         </button>
          </div>
      );
   }
}
export default ButtonGhost;
