########################
# Run tests
########################

module.exports = (grunt) ->
  karma:
    test:
      configFile: 'karma.conf.coffee'
    once:
      configFile: 'karma.conf.coffee'
      singleRun: true
      browsers: ['PhantomJS']
      logLevel: 'ERROR'
