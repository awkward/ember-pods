########################
# Run tests
########################

module.exports = (grunt) ->
  karma:
    test:
      configFile: 'karma.conf.coffee'
