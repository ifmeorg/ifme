// For inspiration on your webpack configuration, see:
// https://github.com/shakacode/react_on_rails/tree/master/spec/dummy/client
// https://github.com/shakacode/react-webpack-rails-tutorial/tree/master/client

const glob = require('glob');
const { resolve } = require('path');
const CompressionPlugin = require('compression-webpack-plugin');
const ExtractCssChunks = require('extract-css-chunks-webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const webpackConfigLoader = require('react-on-rails/webpackConfigLoader');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const baseConfig = require('./webpack.config.base');

const configPath = resolve('..', 'config');
const devOrTestMode = process.env.NODE_ENV === 'development' || process.env.NODE_ENV === 'test';
const { output } = webpackConfigLoader(configPath);
const outputFilename = `[name]${devOrTestMode ? '-[hash]' : ''}`;

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
  mode: devOrTestMode ? 'development' : 'production',
  context: resolve(__dirname),

  entry: {
    // Shims should be singletons, and webpack bundle is always loaded
    webpack_bundle: [
      'es5-shim/es5-shim',
      'es5-shim/es5-sham',
      '@babel/polyfill',
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

  optimization: {
    splitChunks: {
      chunks: 'async',
      minSize: 30000,
      maxSize: 0,
      minChunks: 1,
      maxAsyncRequests: 5,
      maxInitialRequests: 3,
      automaticNameDelimiter: '~',
      name: true,
      cacheGroups: {
        vendors: {
          test: /[\\/]node_modules[\\/]/,
          priority: -10,
        },
        default: {
          minChunks: 2,
          priority: -20,
          reuseExistingChunk: true,
        },
      },
    },
    minimizer: devOrTestMode ? [] : [
      new UglifyJsPlugin({
        sourceMap: false,
      }),
      new OptimizeCssAssetsPlugin({
        cssProcessorOptions: {
          discardComments: {
            removeAll: true,
          },
        },
      }),
      new CompressionPlugin({
        filename: '[path].gz[query]',
        algorithm: 'gzip',
        test: /\.(js|css|html)$/,
        threshold: 10240,
        minRatio: 0.8,
      }),
    ],
  },

  plugins: [
    new ExtractCssChunks({
      filename: `${outputFilename}.css`,
      chunkFilename: `${outputFilename}.chunk.css`,
      hot: !!devOrTestMode,
    }),
    new ManifestPlugin({ publicPath: output.publicPath, writeToFileEmit: true }),
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
        use: 'babel-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.css$/,
        include: /node_modules/,
        use: [
          ExtractCssChunks.loader,
          {
            loader: 'css-loader',
            options: {
              modules: false,
              camelCase: true,
              localIdentName: '[name]__[local]___[hash:base64:5]',
            },
          },
        ],
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        use: [
          ExtractCssChunks.loader,
          cssLoaderWithModules,
        ],
      },
      {
        test: /\.(sass|scss)$/,
        include: /node_modules/,
        use: [
          ExtractCssChunks.loader,
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
      },
      {
        test: /\.(sass|scss)$/,
        exclude: /node_modules/,
        use: [
          ExtractCssChunks.loader,
          cssLoaderWithModules,
          'sass-loader',
        ],
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

if (devOrTestMode) {
  console.log('Webpack dev or test build for Rails'); // eslint-disable-line no-console
  module.exports.devtool = 'eval-source-map';
} else {
  console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}
