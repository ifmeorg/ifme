/* eslint-disable import/no-extraneous-dependencies, import/no-unresolved, import/extensions */
import { addDecorator, addParameters } from '@storybook/react';
import './stories.scss';

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
