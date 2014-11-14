########################
# grunt test - run tests
########################

module.exports = (grunt) ->
  grunt.registerTask 'test', ['build:once', 'karma:once']