const fs = require('fs');

module.exports = {
    configureWebpack: {
      devtool: "source-map"
    },
    devServer: {
      https: true,
      key: fs.readFileSync('../../certs/.certs/localhost.key'),
      cert: fs.readFileSync('../../certs/.certs/localhost.crt')
    }
  };