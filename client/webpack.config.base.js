const path = require('path');

module.exports = {
  resolve: {
    alias: {
      app: path.resolve(__dirname, '../app'),
      config: path.resolve(__dirname, '../config'),
      libs: path.resolve(__dirname, 'app/libs'),
      styles: path.resolve(__dirname, 'app/styles'),
      components: path.resolve(__dirname, 'app/components'),
      utils: path.resolve(__dirname, 'app/utils'),
      mocks: path.resolve(__dirname, 'app/mocks'),
    },
    extensions: ['.js', '.jsx', '.scss'],
  },
};
