/* eslint-disable no-unused-vars */
import React from 'react';
import css from 'styles/_global.scss';

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

const LightBackgroundTemplate = (args) => (
  <div style={rowStyle}>
    <div>
      <h1>Regular</h1>
      {getButton('buttonXS')}
      {getButton('buttonS')}
      {getButton('buttonM')}
      {getButton('buttonL')}
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

export const ButtonsOnLightBackground = LightBackgroundTemplate.bind({});

ButtonsOnLightBackground.storyName = 'Buttons on light background';

const DarkBackgroundTemplate = (args) => (
  <div style={rowStyle}>
    <div>
      <h1 style={{ color: '#FFFFFF' }}>Regular</h1>
      {getButton('buttonXS')}
      {getButton('buttonS')}
      {getButton('buttonM')}
      {getButton('buttonL')}
    </div>
    <div>
      <h1 style={{ color: '#FFFFFF' }}>Ghost</h1>
      {getButton('buttonGhostXS')}
      {getButton('buttonGhostS')}
      {getButton('buttonGhostM')}
      {getButton('buttonGhostL')}
    </div>
  </div>
);

export const ButtonsOnDarkBackground = DarkBackgroundTemplate.bind({});

ButtonsOnDarkBackground.storyName = 'Buttons on dark background';
ButtonsOnDarkBackground.parameters = {
  backgrounds: { default: 'mulberry' },
};
