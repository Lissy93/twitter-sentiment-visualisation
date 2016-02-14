#Set the current environment to true in the env object
currentEnv = process.env.NODE_ENV or 'development'
exports.appName = "Twitter Sentiment Visualisations"
exports.env =
  production: false
  staging: false
  test: false
  development: false
exports.env[currentEnv] = true
exports.log =
  path: __dirname + "reports/log/app_#{currentEnv}.log"
exports.server =
  port: 8080
#In staging and production, listen loopback. nginx listens on the network.
  ip: '127.0.0.1'
if currentEnv not in ['production', 'staging']
  exports.enableTests = true
  #Listen on all IPs in dev/test (for testing from other machines)
  exports.server.ip = '0.0.0.0'
exports.db =
  URL: "mongodb://localhost/" +
    "#{exports.appName.toLowerCase()}_#{currentEnv}".replace RegExp(' ','g'),'-'