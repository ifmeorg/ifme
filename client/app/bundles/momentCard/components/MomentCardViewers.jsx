// @flow
import React from 'react';

type MomentCardViewersProp = {
  viewersText?: string
};

export default class MomentCardViewers extends
  React.Component <MomentCardViewersProp> {
  render() {
    return (
      <div>
        {this.props.viewersText}
      </div>
    );
  }
}
