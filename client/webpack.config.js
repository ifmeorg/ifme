/**
 * TODO: Split up development configuration from production configuration
 * in order to support hot reloading.
 */

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
const devBuild = process.env.NODE_ENV !== 'production';
const { output } = webpackConfigLoader(configPath);
const outputFilename = `[name]-[hash]${devBuild ? '' : '.min'}`;
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

const extractCSS = new ExtractTextPlugin(`${outputFilename}.css`);
const cssLoaderWithModules = {
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
    // Shims should be singletons, and webpack bundle is always loaded
    webpack_bundle: [
      'es5-shim/es5-shim',
      'es5-shim/es5-sham',
      'babel-polyfill',
    ].concat(glob.sync('./app/startup/*')),
  },

  output: {
    // Name comes from the entry section.
    filename: `${outputFilename}.js`,
    chunkFilename: `${outputFilename}.chunk.js`,

    // Leading slash is necessary
    publicPath: `/${output.publicPath}`,
    path: output.path,
  },

  plugins: [
    new webpack.EnvironmentPlugin({
      NODE_ENV: 'development', // use 'development' unless process.env.NODE_ENV is defined
      DEBUG: false,
    }),
    extractCSS,
    new ManifestPlugin({ publicPath: output.publicPath, writeToFileEmit: true }),
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
        include: /node_modules/,
        loader: extractCSS.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                modules: false,
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
          fallback: 'style-loader',
          use: [cssLoaderWithModules],
        }),
      },
      {
        test: /\.(sass|scss)$/,
        include: /node_modules/,
        loader: extractCSS.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                modules: false,
                camelCase: true,
                localIdentName: '[name]__[local]___[hash:base64:5]',
              },
            },
            'sass-loader',
          ],
        }),
      },
      {
        test: /\.(sass|scss)$/,
        exclude: /node_modules/,
        loader: extractCSS.extract({
          fallback: 'style-loader',
          use: [cssLoaderWithModules, 'sass-loader'],
        }),
      },
      {
        test: /\.ya?ml$/,
        loader: 'yml-loader',
      },
      {
        test: /\.(png|jp(e*)g|svg)$/,
        use: [
          {
            loader: 'url-loader',
            options: {
              limit: 8000,
              name: 'images/[hash]-[name].[ext]',
            },
          },
        ],
      },
      {
        test: /\.(eot|svg|ttf|woff|woff2)$/,
        include: /node_modules/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: 'fonts/[hash]-[name].[ext]',
            },
          },
        ],
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
