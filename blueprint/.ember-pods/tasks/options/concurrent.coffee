########################
# Run multiple blocking tasks concurrently
########################

module.exports = (grunt) ->
  concurrent:
    build:
      tasks: ['esteWatch', 'karma']
      options:
        logConcurrentOutput: true
