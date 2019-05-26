// @flow
import React from 'react';
import { Story } from '../Story';
import type { Props as StoryProps } from '../Story';

export type Props = {
  data: StoryProps[],
};

export class StoryContainer extends React.Component<Props> {
  render() {
    const { data } = this.props;
    return (
      <div className="gridTwo">
        {data.map(props => (
          <div className="gridTwoItemBoxLight" key={props.link}>
            <Story {...props} />
          </div>
        ))}
      </div>
    );
  }
}
