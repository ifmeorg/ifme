// @flow
import React from 'react';
import { Story } from 'components/Story';
import type { Props as StoryProps } from 'components/Story';

export type Props = {
  data: StoryProps[],
};

export class StoryContainer extends React.Component<Props> {
  render() {
    const { data } = this.props;
    return (
      <div className="gridTwo">
        {data.map((props) => (
          <div className="gridTwoItemBoxLight" key={props.link}>
            <Story
              date={props.date}
              categories={props.categories}
              moods={props.moods}
              storyType={props.storyType}
              storyBy={props.storyBy}
              actions={props.actions}
              draft={props.draft}
              name={props.name}
              link={props.link}
              body={props.body}
              medicationBody={props.medicationBody}
            />
          </div>
        ))}
      </div>
    );
  }
}
