const path = require('path');
const custom = require('../webpack.config');

module.exports = {
  stories: ['../app/stories/**/*.stories.@(jsx|mdx)'],
  addons: [
    '@storybook/addon-docs',
    '@storybook/addon-links',
    '@storybook/addon-backgrounds',
  ],
  webpackFinal: (config) => {
    config.resolve.modules.push(path.resolve(__dirname, '../..'));

    return {
      ...config,
      module: { ...config.module, rules: custom.module.rules },
      plugins: [ ...config.plugins, ...custom.plugins ],
    };
  },
};
