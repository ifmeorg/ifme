const path = require('path');

module.exports = {
  resolve: {
    alias: {
      app: path.resolve(path.join(process.cwd(), '..', 'app')),
      config: path.resolve(path.join(process.cwd(), '..', 'config')),
      libs: path.resolve(path.join(process.cwd(), 'app', 'libs')),
    },
    extensions: ['.js', '.jsx'],
  },
};
