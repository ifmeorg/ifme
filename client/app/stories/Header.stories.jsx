import React from 'react';
import { storiesOf } from '@storybook/react';
import { Header } from '../components/Header';

storiesOf('Header', module)
  .add('With no active link', () => (
    <Header
      home={{ name: 'if me', link: 'http://if-me.org' }}
      links={[
        { name: 'Link 1', link: '#' },
        { name: 'Link 2', link: '#' },
        { name: 'Link 3', link: '#' },
      ]}
    />
  ))
  .add('With an active link', () => (
    <Header
      home={{ name: 'if me', link: 'http://if-me.org' }}
      links={[
        { name: 'Link 1', link: '#', active: true },
        { name: 'Link 2', link: '#' },
        { name: 'Link 3', link: '#' },
      ]}
    />
  ));
