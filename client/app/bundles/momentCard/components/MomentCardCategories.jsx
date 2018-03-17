// @flow
import React from 'react';
import css from './MomentCard.scss';

type MomentCardCategoriesState = {};

type MomentCardCategoriesProp = {
  category: any
};

export default class MomentCardCategories
  extends React.Component {
  props: MomentCardCategoriesProp;
  state: MomentCardCategoriesState;

  render() {
    const { category } = this.props;
    
    return (
      <div className={css.category}>
        {category}
      </div>
    );
  }
}
