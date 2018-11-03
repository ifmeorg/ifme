import 'font-awesome/scss/font-awesome.scss';
import React from 'react';
import { storiesOf } from '@storybook/react';
import { Story } from '../components/Story';
import css from '../styles/_global.scss';

storiesOf('Story', module)
  .add('no options', () => (
    <div className={`${css.gridTwoItemBoxLight} gridTwoItemBoxLight`}>
      <Story name="Real Moment" link="some-url" />
    </div>
  ))
  .add('all options', () => (
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
        categories={['FRIENDS', 'FAMILY']}
        moods={['ANXIOUS', 'HELPFUL']}
        date="Created 2 Days ago"
        draft="Draft"
        storyType="Some Type"
        storyBy={{ author: 'Some Person' }}
      />
    </div>
  ));
