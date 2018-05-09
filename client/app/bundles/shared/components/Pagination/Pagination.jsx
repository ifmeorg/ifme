import React from 'react';
import css from './Pagination.scss';

export default class Pagination extends React.Component {

   constructor(props) {
      super(props);
      this.state = {
         active: 1,  // which page we are on
         pages: 3    // the amount of pages we have
      };
      this.togglePages = this.togglePages.bind(this);
   }

   togglePages(event) {
      this.setState({ active: parseInt(event.target.value) }, () => {
         console.log(`We are on page ${this.state.active}`);
      })
   }

   render() {
      const buttonElements = (howMany: int) => {
         let elements = [], val = howMany;
         while (val > 0) {
            elements.unshift(
               <button className={css.circle} onClick={this.togglePages} value={val} key={val - 1}
                  style={{ 'background': this.state.active === val ? '#ffffff' : '#B2B2B2' }}>
                  <span className={css.number}
                     style={{ 'color': this.state.active === val ? '#59002B' : '#ffffff' }}>{val}</span>
               </button>
            )
            val--;
         }
         return elements;
      }

      return (
         <div className={css.pagination}>
            {buttonElements(this.state.pages)}
         </div>
      )
   }
}