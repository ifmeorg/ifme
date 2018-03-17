// @flow
import React from 'react';

type MomentCardViewersState = {};

type MomentCardViewersProp = {
  viewersText?: string
};

export default class MomentCardViewers extends
  React.Component {
  props: MomentCardViewersProp;
  state: MomentCardViewersState;

  render() {
    return (
      <div>
        {this.props.viewersText}
      </div>
    );
  }
}
