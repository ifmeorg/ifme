// For inspiration on your webpack configuration, see:
// https://github.com/shakacode/react_on_rails/tree/master/spec/dummy/client
// https://github.com/shakacode/react-webpack-rails-tutorial/tree/master/client

const webpack = require('webpack');
const { resolve } = require('path');

const CompressionPlugin = require('compression-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const webpackConfigLoader = require('react-on-rails/webpackConfigLoader');

const configPath = resolve('..', 'config');
const { devBuild, manifest, webpackOutputPath, webpackPublicOutputDir } =
  webpackConfigLoader(configPath);
const outputFilename = `[name]-[hash]${devBuild ? '' : '.min'}`;

const config = {

  context: resolve(__dirname),

  entry: {
    'webpack-bundle': [
      'es5-shim/es5-shim',
      'es5-shim/es5-sham',
      'babel-polyfill',
      './app/bundles/momentDashboards/startup/registration',
      './app/bundles/shared/startup/registration',
    ],
  },

  output: {
    // Name comes from the entry section.
    filename: `${outputFilename}.js`,

    // Leading slash is necessary
    publicPath: `/${webpackPublicOutputDir}`,
    path: webpackOutputPath,
  },

  resolve: {
    extensions: ['.js', '.jsx'],
  },

  plugins: [
    new webpack.EnvironmentPlugin({
      NODE_ENV: 'development', // use 'development' unless process.env.NODE_ENV is defined
      DEBUG: false,
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: devBuild ? false : {
        dead_code: true,
        warnings: false,
      },
      mangle: !devBuild,
    }),
    new ManifestPlugin({ fileName: manifest, writeToFileEmit: true }),
    new ExtractTextPlugin(`${outputFilename}.css`),
  ].concat(devBuild ? [] : [
    /**
     * OptimizeCssAssetsPlugin doesn't play nicely with CompressionPlugin; enabling OptimizeCssAssetsPlugin
     * prevents the CSS from being gzipped. Since we use OptimizeCssAssetsPlugin primarily to remove
     * comments, I value gzip over comment removal for now.
     *
     * A GitHub issue is already filed for this problem:
     * https://github.com/webpack-contrib/compression-webpack-plugin/issues/62
     */
    // new OptimizeCssAssetsPlugin({
    //   cssProcessorOptions: {
    //     discardComments: {
    //       removeAll: true,
    //     },
    //   },
    // }),
    new CompressionPlugin({
      asset: '[path].gz[query]',
      algorithm: 'gzip',
      test: /\.(js|css|html)$/,
      threshold: 10240,
      minRatio: 0.8
    }),
  ]),

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
        use: 'babel-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: 'css-loader?modules&camelCase&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]!sass-loader',
        }),
        include: resolve(__dirname, './app/bundles'),
      },
    ],
  },
};

module.exports = config;

if (devBuild) {
  console.log('Webpack dev build for Rails'); // eslint-disable-line no-console
  module.exports.devtool = 'eval-source-map';
} else {
  console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}
