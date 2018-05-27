import React from 'react';
import css from './button.scss';

<<<<<<< HEAD
class ButtonGhost extends React.Component {
   render() {
=======

class ButtonGhost extends React.Component {
   render() {
       
       
>>>>>>> de271eeff4bd25dd1a823a75c2764335014d096a
      return (
         <button className = {css.buttonGhost}>
            {this.props.text}
         </button>
      );
   }
}
export default ButtonGhost;
