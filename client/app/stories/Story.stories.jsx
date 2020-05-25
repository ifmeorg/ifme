import 'font-awesome/scss/font-awesome.scss';
import React from 'react';
import { Story } from '../components/Story';
import css from '../styles/_global.scss';

export default {
  title: 'Components/Story',
};

export const NoOptions = () => (
  <div className={`${css.gridTwoItemBoxLight} gridTwoItemBoxLight`}>
    <Story name="Real Moment" link="some-url" />
  </div>
);

NoOptions.story = {
  name: 'no options',
};

export const AllOptions = () => (
  <div className={`${css.gridTwoItemBoxLight} gridTwoItemBoxLight`}>
    <Story
      actions={{
        edit: { link: 'some-url', name: 'Edit' },
        delete: {
          link: 'some-url',
          name: 'Delete',
          dataMethod: 'delete',
          dataConfirm: 'Are you sure?',
        },
        report: { link: 'some-url', name: 'Report' },
        viewers: 'blah',
      }}
      name="Real Moment"
      link="some-url"
      categories={[
        { name: 'Family', slug: '/family' },
        { name: 'Friends', slug: '/friends' },
      ]}
      moods={[
        { name: 'Nervous', slug: '/nervous' },
        { name: 'Excited', slug: '/excited' },
      ]}
      date="Created 2 Days ago"
      draft="Draft"
      storyType="Some Type"
      storyBy={{ author: 'Some Person' }}
    />
  </div>
);

AllOptions.story = {
  name: 'all options',
};
