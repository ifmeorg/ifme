/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Header } from 'components/Header';

export default {
  title: 'Components/Header',
  component: Header,
};

const Template = (args) => <Header {...args} />;

export const NoActiveLink = Template.bind({});

NoActiveLink.args = {
  home: { name: 'if me', link: 'http://if-me.org' },
  links: [
    { name: 'Link 1', link: '#' },
    { name: 'Link 2', link: '#' },
    { name: 'Link 3', link: '#' },
  ],
};
NoActiveLink.storyName = 'With no active link';
NoActiveLink.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const HasActiveLink = Template.bind({});

HasActiveLink.args = {
  home: { name: 'if me', link: 'http://if-me.org' },
  links: [
    { name: 'Link 1', link: '#', active: true },
    { name: 'Link 2', link: '#' },
    { name: 'Link 3', link: '#' },
  ],
};
HasActiveLink.storyName = 'With an active link';
HasActiveLink.parameters = {
  backgrounds: { default: 'mulberry' },
};
