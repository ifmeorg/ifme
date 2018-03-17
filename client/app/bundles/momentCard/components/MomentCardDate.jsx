// @flow
import React from 'react';
import css from './MomentCard.scss';

type MomentCardDateState = {};

type MomentCardDateProp = {
  date: string
};

export default class MomentCardDate
  extends React.Component {
  props: MomentCardDateProp;
  state: MomentCardDateState;

  render() {
    return (
      <div className={css.date}>
        {this.props.date}
      </div>
    );
  }
}
