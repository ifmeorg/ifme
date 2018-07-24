// @flow
import React from 'react';
import css from './MomentCard.scss';

type MomentCardNameProp = {
  name: string,
};

export class MomentCardName extends React.Component<MomentCardNameProp> {
  render() {
    return <div className={css.name}>{this.props.name}</div>;
  }
}
