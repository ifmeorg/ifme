// @flow
import React from 'react';

type MomentCardDateState = {};

type MomentCardDateProp = {
  date: string;
};

export default class MomentCardDate
  extends React.Component<MomentCardDateProp, MomentCardDateState> {
  props: MomentCardDateProp;
  state: MomentCardDateState;

  render() {
    return (
      <div className="moment_date">
        {this.props.date}
      </div>
    );
  }
}
