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

function loadStories() {
  require('../app/stories/index');
}

configure(loadStories, module);
