// karma.conf.js
var webpackConfig = require('./webpack.config');
const webpack = require('webpack');

webpackConfig.plugins = [
    new webpack.EnvironmentPlugin({
        NODE_ENV: 'development', // use 'development' unless process.env.NODE_ENV is defined
        DEBUG: false,
    }),
];
webpackConfig.devtool = 'eval-source-map';

// https://github.com/airbnb/enzyme/blob/master/docs/guides/webpack.md#react-15-compatibility
webpackConfig.externals = {
    'react/addons': true,
    'react/lib/ExecutionEnvironment': true,
    'react/lib/ReactContext': true,
    'react-addons-test-utils': 'react-dom',
};

module.exports = function (config) {
    config.set({
        browsers: ['PhantomJS'],
        singleRun: true,
        frameworks: ['jasmine'],
        files: [
            { pattern: 'app/**/*.spec.jsx', watched: true },
        ],
        preprocessors: {
            'app/**/*.jsx': ['webpack', 'sourcemap']
        },
        reporters: ['dots'],
        webpack: webpackConfig,
        webpackServer: {
            noInfo: true
        }
    });
};
