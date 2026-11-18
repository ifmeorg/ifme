import path from 'node:path';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';

const require = createRequire(import.meta.url);
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const custom = require('../webpack.config.js');

export default {
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
    '@storybook/addon-docs',
  ],
  features: {
    controls: false,
    actions: false,
    sidebarOnboardingChecklist: false,
    menuOnboardingChecklist: false,
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
