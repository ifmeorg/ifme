const path = require('path');
const custom = require('../webpack.config');

module.exports = {
  framework: {
    name: '@storybook/react-webpack5',
    options: {},
  },
  stories: [
    '../app/stories/Index.stories.jsx',
    '../app/stories/**/*.stories.jsx',
  ],
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
  docs: {
    autodocs: true,
  },
  webpackFinal: (config) => {
    config.resolve.modules.push(path.resolve(__dirname, '../..'));

    return {
      ...config,
      module: {
        ...config.module,
        rules: [
          // Storybook's rules for ESM packages (needed with React 17)
          { test: /\.m?js$/, type: 'javascript/auto' },
          { test: /\.m?js$/, resolve: { fullySpecified: false } },
          ...custom.module.rules,
        ],
      },
      plugins: [ ...config.plugins, ...custom.plugins ],
      resolve: {
        ...config.resolve,
        ...custom.resolve,
        alias: { ...config.resolve.alias, ...custom.resolve.alias },
        extensions: [ ...new Set([ ...config.resolve.extensions, ...custom.resolve.extensions ]) ],
      },
    };
  },
};
