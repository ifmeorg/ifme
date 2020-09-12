/* eslint-disable import/no-extraneous-dependencies, import/no-unresolved, import/extensions */
import { setDefaults, withInfo } from '@storybook/addon-info';
import { addDecorator, addParameters } from '@storybook/react';
import './stories.scss';

// addon-info
setDefaults({
  header: true,
  inline: true,
  source: true,
  propTables: false,
});

export const parameters = {
  backgrounds: {
    default: 'light-grey',
    values: [
      { name: 'light-grey', value: '#D3D3D3' },
      { name: 'grey', value: '#808080' },
      { name: 'white', value: '#FFFFFF' },
      { name: 'mulberry', value: '#6D0839' },
    ],
  },
};

addDecorator(withInfo({
  styles: {
    infoBody: { margin: '0', padding: '20px' },
    infoPage: { margin: '0' },
    infoStory: { margin: '0', padding: '20px 0' },
    source: { h1: { margin: '0' } },
  },
}));
