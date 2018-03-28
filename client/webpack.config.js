// For inspiration on your webpack configuration, see:
// https://github.com/shakacode/react_on_rails/tree/master/spec/dummy/client
// https://github.com/shakacode/react-webpack-rails-tutorial/tree/master/client

const webpack = require('webpack');
const baseConfig = require('./webpack.config.base');
const glob = require('glob');
const { resolve } = require('path');

const CompressionPlugin = require('compression-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');
// const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const webpackConfigLoader = require('react-on-rails/webpackConfigLoader');

const configPath = resolve('..', 'config');
const { devBuild, manifest, webpackOutputPath, webpackPublicOutputDir } =
  webpackConfigLoader(configPath);
const outputFilename = `[name]-[hash]${devBuild ? '' : '.min'}`;
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

const extractCSS = new ExtractTextPlugin(`${outputFilename}.css`);
const cssLoader = {
  loader: 'css-loader',
  options: {
    modules: true,
    camelCase: true,
    importLoaders: 1,
    localIdentName: '[name]__[local]___[hash:base64:5]',
  },
};

const config = Object.assign(baseConfig, {

  context: resolve(__dirname),

  entry: {
    'webpack-bundle': [
      'es5-shim/es5-shim',
      'es5-shim/es5-sham',
      'babel-polyfill',
    ].concat(glob.sync('./app/bundles/**/startup/*')),
  },

  output: {
    // Name comes from the entry section.
    filename: `${outputFilename}.js`,

    // Leading slash is necessary
    publicPath: `/${webpackPublicOutputDir}`,
    path: webpackOutputPath,
  },

  plugins: [
    new webpack.EnvironmentPlugin({
      NODE_ENV: 'development', // use 'development' unless process.env.NODE_ENV is defined
      DEBUG: false,
    }),
    new ManifestPlugin({ fileName: manifest, writeToFileEmit: true }),
    extractCSS,
  ].concat(devBuild ? [] : [
    new UglifyJsPlugin({
      sourceMap: false,
    }),
    /**
     * OptimizeCssAssetsPlugin doesn't play nicely with CompressionPlugin; enabling
     * OptimizeCssAssetsPlugin prevents the CSS from being gzipped. Since we use
     * OptimizeCssAssetsPlugin primarily to remove comments, I value gzip over comment
     * removal for now.
     *
     * A GitHub issue is already filed for this problem:
     * https://github.com/webpack-contrib/compression-webpack-plugin/issues/62
     *
     * Re-enable this plugin once the issue has been resolved.
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
      minRatio: 0.8,
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
            }
          ],
        }),
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        loader: extractCSS.extract({
          fallback: 'style-loader',
          use: [
            cssLoader
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

module.exports = config;

if (devBuild) {
  console.log('Webpack dev build for Rails'); // eslint-disable-line no-console
  module.exports.devtool = 'eval-source-map';
} else {
  console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}
