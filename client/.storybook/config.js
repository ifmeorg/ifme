/* eslint-disable import/no-extraneous-dependencies, import/no-unresolved, import/extensions */
import { setDefaults, withInfo } from '@storybook/addon-info';
import { addDecorator, configure, addParameters } from '@storybook/react';
import { lightGrey, grey, white, mulberry } from './backgrounds';
import './stories.scss';

// addon-info
setDefaults({
  header: true,
  inline: true,
  source: true,
  propTables: false,
});

addParameters({
  backgrounds: [
    {...lightGrey, default: true},
    grey,
    white,
    mulberry,
  ],
});

const withInfoConfig = {
  styles: {
    infoBody: { margin: '0', padding: '20px' },
    infoPage: { margin: '0' },
    infoStory: { margin: '0', padding: '20px 0' },
    source: { h1: { margin: '0' } },
  },
};

const globalDecorator = (storyFn, context) =>
  withInfo(withInfoConfig)(storyFn)(context);
  addDecorator(globalDecorator);
