/* eslint-disable import/no-extraneous-dependencies, import/no-unresolved, import/extensions */
import backgrounds from '@storybook/addon-backgrounds';
import { setDefaults, withInfo } from '@storybook/addon-info';
import { setIntlConfig, withIntl } from 'storybook-addon-intl';
import { addDecorator, configure } from '@storybook/react';

import { loadLocales } from 'libs/i18n/I18nSetup';
import { availableLocalesAsCodeArray, defaultLocale, getMessages } from 'libs/i18n/I18nUtils';

import './stories.scss';

// addon-info
setDefaults({
  header: true,
  inline: true,
  source: true,
  propTables: false,
});

const withInfoConfig = {
  styles: {
    infoBody: { margin: '0', padding: '20px' },
    infoPage: { margin: '0' },
    infoStory: { margin: '0', padding: '20px 0' },
    source: { h1: { margin: '0' } },
  },
};

const globalDecorator = (storyFn, context) => withInfo(withInfoConfig)(storyFn)(context);
addDecorator(globalDecorator);
loadLocales();
setIntlConfig({
  locales: availableLocalesAsCodeArray,
  defaultLocale,
  getMessages,
});
addDecorator(withIntl);
addDecorator(backgrounds([
  { name: 'mulberry-wood', value: '#6D0839' },
  { name: 'dark-gray', value: '#3F3F3F' }, // 25% gray
  { name: 'gray', value: '#7F7F7F' }, // 50% gray
  { name: 'light-gray', value: '#BFBFBF', default: true }, // 75% gray
  { name: 'white', value: '#FFFFFF' },
]));

// automatically import all files ending in *.stories.jsx
const req = require.context('../app/stories', true, /.stories.jsx$/);
function loadStories() {
  req.keys().forEach((filename) => req(filename));
}

configure(loadStories, module);
