const path = require('path');

module.exports = {
  resolve: {
    alias: {
      libs: path.resolve(path.join(process.cwd(), 'app', 'libs')),
      config: path.resolve(path.join(process.cwd(), '..', 'config')),
    },
    extensions: ['.js', '.jsx'],
  },
};
