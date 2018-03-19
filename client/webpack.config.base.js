const path = require('path');

module.exports = {
  resolve: {
    alias: {
      libs: path.resolve(path.join(process.cwd(), 'app', 'libs')),
      config: path.resolve(path.join(process.cwd(), '..', 'config')),
      app: path.resolve(path.join(process.cwd(), '..', 'app')),
    },
    extensions: ['.js', '.jsx'],
  },
};
