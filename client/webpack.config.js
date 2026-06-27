// For inspiration on your webpack configuration, see:
// https://github.com/shakacode/react_on_rails/tree/master/spec/dummy/client
// https://github.com/shakacode/react-webpack-rails-tutorial/tree/master/client

const glob = require('glob');
const { resolve } = require('path');
const CompressionPlugin = require('compression-webpack-plugin');
const { WebpackManifestPlugin } = require('webpack-manifest-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const webpackConfigLoader = require('react-on-rails/webpackConfigLoader');
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const webpack = require('webpack');
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

const configPath = resolve('..', 'config');
const devOrTestMode = process.env.NODE_ENV === 'development' || process.env.NODE_ENV === 'test';
const { output } = webpackConfigLoader(configPath);
const outputFilename = `[name]${devOrTestMode ? '-[contenthash]' : ''}`;

const cssLoaderWithModules = {
  loader: 'css-loader',
  options: {
    modules: {
      localIdentName: '[name]__[local]___[hash:base64:5]',
    },
    localsConvention: 'camelCase',
    importLoaders: 1,
  },
};

const config = {
  mode: devOrTestMode ? 'development' : 'production',
  context: resolve(__dirname),

  resolve: {
    alias: {
      app: resolve(__dirname, '../app'),
      config: resolve(__dirname, '../config'),
      libs: resolve(__dirname, 'app/libs'),
      styles: resolve(__dirname, 'app/styles'),
      components: resolve(__dirname, 'app/components'),
      utils: resolve(__dirname, 'app/utils'),
      mocks: resolve(__dirname, 'app/mocks'),
      widgets: resolve(__dirname, 'app/widgets'),
      workers: resolve(__dirname, 'app/workers'),
      pages: resolve(__dirname, 'app/pages'),
      moment: resolve(__dirname, 'app/libs/moment-compat.js'),
    },
    extensions: ['.js', '.jsx', '.scss'],
  },

  entry: {
    webpack_bundle: glob.sync('./app/startup/*'),
  },

  output: {
    // Name comes from the entry section.
    filename: `${outputFilename}.js`,
    chunkFilename: `${outputFilename}.chunk.js`,
    publicPath: output.publicPath,
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
      cacheGroups: {
        defaultVendors: {
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
      new CssMinimizerPlugin(),
      new CompressionPlugin({
        filename: '[path][base].gz[query]',
        algorithm: 'gzip',
        test: /\.(js|css|html)$/,
        threshold: 10240,
        minRatio: 0.8,
      }),
      new TerserPlugin(),
    ],
  },

  plugins: [
    new MiniCssExtractPlugin({
      filename: `${outputFilename}.css`,
      chunkFilename: `${outputFilename}.chunk.css`,
    }),
    new WebpackManifestPlugin({ publicPath: output.publicPath, writeToFileEmit: true }),
    new NodePolyfillPlugin(),
    ...(process.env.BUNDLE_ANALYZE ? [new BundleAnalyzerPlugin({ analyzerMode: 'static', openAnalyzer: false })] : []),
  ],

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        use: 'babel-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.css$/,
        include: /node_modules/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              modules: {
                localIdentName: '[name]__[local]___[hash:base64:5]',
              },
              localsConvention: 'camelCase',
            },
          },
        ],
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        use: [
          MiniCssExtractPlugin.loader,
          cssLoaderWithModules,
        ],
      },
      {
        test: /\.(sass|scss)$/,
        include: /node_modules/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              modules: {
                localIdentName: '[name]__[local]___[hash:base64:5]',
              },
              localsConvention: 'camelCase',
            },
          },
          'sass-loader',
        ],
      },
      {
        test: /\.(sass|scss)$/,
        exclude: /node_modules/,
        use: [
          MiniCssExtractPlugin.loader,
          cssLoaderWithModules,
          'sass-loader',
        ],
      },
      {
        test: /\.ya?ml$/,
        loader: 'yml-loader',
      },
      {
        test: /\.(png|jp(e*)g|svg|webp)$/,
        type: 'asset',
        parser: {
          dataUrlCondition: {
            maxSize: 8000,
          },
        },
        generator: {
          filename: 'images/[contenthash]-[name][ext]',
        }
      },
      {
        test: /\.(eot|svg|ttf|woff|woff2)$/,
        include: /node_modules/,
        type: 'asset/resource',
        generator: {
          filename: 'fonts/[contenthash]-[name][ext]',
        }
      },
    ],
  },
};

module.exports = config;

if (devOrTestMode) {
  console.log('Webpack dev or test build for Rails'); // eslint-disable-line no-console
  module.exports.devtool = 'eval-source-map';
} else {
  console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}
