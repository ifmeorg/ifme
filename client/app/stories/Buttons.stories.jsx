import React from 'react';
import css from '../styles/_global.scss';

const rowStyle = {
  display: 'flex',
  flexDirection: 'row',
  justifyContent: 'space-evenly',
};

const getButton = (className) => (
  <p>
    <button type="button" className={`${css[className]} ${className}`}>
      {`${className}`}
    </button>
  </p>
);

export default {
  title: 'Style Guide/Buttons',
};

export const Buttons = () => (
  <div style={rowStyle}>
    <div>
      <h1>Default</h1>
      {getButton('buttonXS')}
      {getButton('buttonS')}
      {getButton('buttonM')}
      {getButton('buttonL')}
    </div>
    <div>
      <h1>Ghost</h1>
      {getButton('buttonGhostXS')}
      {getButton('buttonGhostS')}
      {getButton('buttonGhostM')}
      {getButton('buttonGhostL')}
    </div>
    <div>
      <h1>Dark</h1>
      {getButton('buttonDarkXS')}
      {getButton('buttonDarkS')}
      {getButton('buttonDarkM')}
      {getButton('buttonDarkL')}
    </div>
  </div>
);

Buttons.story = {
  parameters: {
    componentSubtitle:
      'Default can be used for anything. Ghost is for pages that are pre-login. Dark is for account pages.',
  },
};
