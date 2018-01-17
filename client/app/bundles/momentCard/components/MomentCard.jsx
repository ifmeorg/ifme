// @flow
import React from 'react';
import MomentCardName from './MomentCardName';
import MomentCardDate from './MomentCardDate';
import MomentCardSettings from './MomentCardSettings';

type MomentCardState = {};

type MomentCardProp = {
  item: {
    name: string;
  };
  date: string;
};

export default class MomentCard extends React.Component<MomentCardProp, MomentCardState> {
  props: MomentCardProp;
  state: MomentCardState;

  render() {
    return (
      <div>
        <div className="moment_header">
          <MomentCardName name={this.props.item.name} />
          <MomentCardSettings />
        </div>
        <MomentCardDate date={this.props.date} />
      </div>
    );
  }
}
