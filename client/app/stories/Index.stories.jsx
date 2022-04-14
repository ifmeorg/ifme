import React from 'react';
import { Logo } from 'components/Logo';
import css from 'styles/_global.scss';

export default {
  title: 'Home',
};

export const Welcome = () => (
  <div
    style={{
      color: '#FFFFFF',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'center',
      alignItems: 'center',
      height: '100vh',
      textAlign: 'center',
    }}
  >
    <Logo lg link="https://if-me.org" />
    <p style={{ marginTop: '40px' }}>
      Welcome to our official design system!
      <br />
      <em>Components</em>
      {' '}
      and
      <em>libraries</em>
      {' '}
      are used in React.
      <br />
      The
      {' '}
      <em>style guide</em>
      {' '}
      is used across Rails and React.
    </p>
    <p
      style={{
        marginTop: '40px',
        display: 'flex',
      }}
    >
      <a
        className={css.buttonGhostM}
        target="_blank"
        href="https://github.com/ifmeorg/ifme/tree/main/client/app/stories"
        rel="noreferrer"
      >
        Source Code
      </a>
      <a
        className={css.buttonGhostM}
        target="_blank"
        style={{ marginLeft: '10px' }}
        href="https://github.com/ifmeorg/ifme/wiki/Frontend-Practices"
        rel="noreferrer"
      >
        Frontend Practices
      </a>
    </p>
  </div>
);

Welcome.parameters = {
  viewMode: 'story',
  backgrounds: { default: 'mulberry' },
  previewTabs: {
    'storybook/docs/panel': {
      hidden: true,
    },
  },
};
