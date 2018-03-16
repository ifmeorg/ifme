/* eslint-disable import/no-extraneous-dependencies, import/no-unresolved, import/extensions */
import { configure } from '@storybook/react';
import { setDefaults } from '@storybook/addon-info';

// addon-info
setDefaults({
  header: true,
  inline: true,
  source: true,
  propTables: false,
});

// automatically import all files ending in *.stories.(jsx|tsx)
const req = require.context('../app/stories', true, /.stories.jsx$/);
function loadStories() {
  req.keys().forEach((filename) => req(filename));
}

configure(loadStories, module);
