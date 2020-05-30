import React from 'react';
import { Header } from '../components/Header';
import { mulberry } from '../../.storybook/backgrounds';

export default {
  title: 'Components/Header',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const WithNoActiveLink = () => (
  <Header
    home={{ name: 'if me', link: 'http://if-me.org' }}
    links={[
      { name: 'Link 1', link: '#' },
      { name: 'Link 2', link: '#' },
      { name: 'Link 3', link: '#' },
    ]}
  />
);

WithNoActiveLink.story = {
  name: 'With no active link',
};

export const WithAnActiveLink = () => (
  <Header
    home={{ name: 'if me', link: 'http://if-me.org' }}
    links={[
      { name: 'Link 1', link: '#', active: true },
      { name: 'Link 2', link: '#' },
      { name: 'Link 3', link: '#' },
    ]}
  />
);

WithAnActiveLink.story = {
  name: 'With an active link',
};
