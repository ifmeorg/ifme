const path = require('path');

const baseConfig = require('../webpack.config.base');

module.exports = Object.assign(baseConfig, {

  resolve: {
    alias: {
      app: path.resolve(__dirname, '../../app/'),
      config: path.resolve(__dirname, '../../config/'),
      libs: path.resolve(__dirname, '../../app/libs/'),
    },
    modules: [
      'client/app',
      'node_modules',
    ],
  },

  module: {
    rules: [
      {
        test: /\.scss$/,
        loader: 'style-loader!css-loader?modules&camelCase&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]!sass-loader',
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
