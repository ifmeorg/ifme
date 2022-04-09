const path = require('path');
const custom = require('../webpack.config');

module.exports = {
  stories: ['../app/stories/**/*.stories.@(jsx|mdx)'],
  addons: [
    '@storybook/addon-links',
    {
      name: '@storybook/addon-essentials',
      options: {
        controls: false,
        actions: false,
      }
    },
  ],
  webpackFinal: (config) => {
    config.resolve.modules.push(path.resolve(__dirname, '../..'));

    return {
      ...config,
      module: { ...config.module, rules: custom.module.rules },
      plugins: [ ...config.plugins, ...custom.plugins ],
      resolve: { ...config.resolve, ...custom.resolve },
    };
  },
};
