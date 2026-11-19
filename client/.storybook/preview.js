/* eslint-disable import/no-extraneous-dependencies, import/no-unresolved, import/extensions */
import React from 'react';
import './stories.scss';

export const parameters = {
  backgrounds: {
    options: {
      'light-grey': { name: 'light-grey', value: '#D3D3D3' },
      grey: { name: 'grey', value: '#808080' },
      white: { name: 'white', value: '#FFFFFF' },
      mulberry: { name: 'mulberry', value: '#6D0839' },
    },
  },
  viewMode: 'docs',
};

export const initialGlobals = {
  backgrounds: {
    value: 'light-grey',
  },
};

export const tags = ['autodocs'];
