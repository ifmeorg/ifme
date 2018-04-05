const path = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const baseConfig = require('../webpack.config.base');

const extractCSS = new ExtractTextPlugin({
  filename: '[name]-[hash].css',
  disable: true, // Set diable to true so that CSS works with hot reloading
});
const cssLoaderWithModules = {
  loader: 'css-loader',
  options: {
    modules: true,
    camelCase: true,
    importLoaders: 1, // Process @import inside CSS files
    localIdentName: '[name]__[local]___[hash:base64:5]',
  },
};

module.exports = Object.assign(baseConfig, {

  resolve: {
    alias: baseConfig.resolve.alias,
    extensions: baseConfig.resolve.extensions,
    modules: [
      'client/app',
      'node_modules',
    ],
  },

  plugins: [
    extractCSS,
  ],

  module: {
    rules: [
      {
        test: require.resolve('react'),
        use: {
          loader: 'imports-loader',
          options: {
            shim: 'es5-shim/es5-shim',
            sham: 'es5-shim/es5-sham',
          },
        },
      },
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: 'babel-loader',
      },
      {
        test: /\.css$/,
        include: /node_modules\/antd/,
        loader: extractCSS.extract({
          // Don't need singleton for hot reload, since we don't expect styles to change
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                modules: false, // Prevent class renaming
                camelCase: true,
                localIdentName: '[name]__[local]___[hash:base64:5]',
              },
            },
          ],
        }),
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        loader: extractCSS.extract({
          /**
           * Use singleton to force reloading entire stylesheet whenever there is a
           * change during hot reload.
           */
          fallback: 'style-loader?singleton',
          use: [cssLoaderWithModules],
        }),
      },
      {
        test: /\.(sass|scss)$/,
        loader: extractCSS.extract({
          /**
           * Use singleton to force reloading entire stylesheet whenever there is a
           * change during hot reload.
           */
          fallback: 'style-loader?singleton',
          use: [cssLoaderWithModules, 'sass-loader'],
        }),
      },
      {
        test: /\.ya?ml$/,
        loader: 'yml-loader',
      },
      {
        test: /\.(png|jp(e*)g|svg)$/,
        use: [{
          loader: 'url-loader',
          options: {
            limit: 8000,
            name: 'images/[hash]-[name].[ext]',
          },
        }],
      },
    ],
  },
});
