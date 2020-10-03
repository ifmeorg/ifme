const path = require('path');

module.exports = {
  resolve: {
    alias: {
      app: path.resolve(__dirname, '../app'),
      config: path.resolve(__dirname, '../config'),
      libs: path.resolve(__dirname, 'app/libs'),
      styles: path.resolve(__dirname, 'app/styles'),
      components: path.resolve(__dirname, 'app/components'),
    },
    extensions: ['.js', '.jsx', '.scss'],
  },
};
