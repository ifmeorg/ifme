// @flow
import React from 'react';
import css from './MomentCard.scss';

type MomentCardNameState = {};

type MomentCardNameProp = {
  name: string;
};

export default class MomentCardName extends
  React.Component {
  props: MomentCardNameProp;
  state: MomentCardNameState;

  render() {
    return (
      <div className={css.name}>
        {this.props.name}
      </div>
    );
  }
}
