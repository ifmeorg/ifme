// @flow
import React from 'react';
import { Story } from 'components/Story';
import type { Props as StoryProps } from 'components/Story';

export type Props = {
  data: StoryProps[],
};

const StoryContainer = ({ data }: Props) => (
  <div className="gridTwo">
    {data.map((storyProps) => (
      <div className="gridTwoItemBoxLight" key={storyProps.link}>
        <Story
          date={storyProps.date}
          categories={storyProps.categories}
          moods={storyProps.moods}
          storyType={storyProps.storyType}
          storyBy={storyProps.storyBy}
          actions={storyProps.actions}
          draft={storyProps.draft}
          name={storyProps.name}
          link={storyProps.link}
          body={storyProps.body}
          medicationBody={storyProps.medicationBody}
        />
      </div>
    ))}
  </div>
);

export default StoryContainer;
