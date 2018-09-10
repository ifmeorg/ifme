import React from 'react';
import { storiesOf } from '@storybook/react';
import { Resource } from '../components/Resource';

const tags = [
  'open_source',
  'tech_industry',
  'free',
  'workplace',
  'podcast',
  'books',
];

storiesOf('Resource', module)
  .add('With tags', () => (
    <Resource
      tagged
      tags={tags.concat(tags)}
      title={'LifeSIGNS: Self Injury Guidance & Network Support (UK)'}
      link={'http://www.lifesigns.org.uk/'}
    />
  ))
  .add('Without tags', () => (
    <Resource
      external
      title={
        'A very long title for a resource that should wrap to two lines and then some or not'
      }
      link={'www.if-me.org'}
      author={
        'Author with a very very long name that is usually an edge case'
      }
    />
  ))
  .add('With all options', () => (
    <Resource
      tagged
      external
      tags={tags.concat(tags)}
      title={
        'Invisible Illnesses: depression is an ocean, and another measure to consider'
      }
      link={'www.if-me.org'}
      author={'Desi Rottman'}
    />
  ));
