// @flow
import React from 'react';

type MomentCardNameState = {};

type MomentCardNameProp = {
  name: string;
};

export default class MomentCardName extends
  React.Component<MomentCardNameProp, MomentCardNameState> {
  props: MomentCardNameProp;
  state: MomentCardNameState;

  render() {
    return (
      <div className="moment_name">
        {this.props.name}
      </div>
    );
  }
}
