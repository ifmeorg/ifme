const path = require('path');

module.exports = {
  resolve: {
    alias: {
      app: path.resolve(__dirname, '../app'),
      config: path.resolve(__dirname, '../config'),
      libs: path.resolve(__dirname, 'app/libs'),
    },
    extensions: ['.js', '.jsx'],
  },
};
