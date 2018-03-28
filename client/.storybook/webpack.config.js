const path = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const baseConfig = require('../webpack.config.base');

const extractCSS = new ExtractTextPlugin('[name]-[hash].css');
const cssLoader = {
  loader: 'css-loader',
  options: {
    modules: true,
    camelCase: true,
    importLoaders: 1,
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
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                modules: false,
                camelCase: true,
                importLoaders: 1,
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
          fallback: 'style-loader',
          use: [
            cssLoader,
          ],
        }),
      },
      {
        test: /\.(sass|scss)$/,
        loader: extractCSS.extract({
          fallback: 'style-loader',
          use: [
            cssLoader,
            'sass-loader',
          ],
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
