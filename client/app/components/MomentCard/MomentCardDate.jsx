// @flow
import React from 'react';
import css from './MomentCard.scss';

type MomentCardDateProp = {
  date: string,
};

export class MomentCardDate extends React.Component<MomentCardDateProp> {
  render() {
    return <div className={css.date}>{this.props.date}</div>;
  }
}
