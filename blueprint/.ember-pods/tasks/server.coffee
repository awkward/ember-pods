########################
# grunt server - build, watch, livereload and serve using express server
########################

module.exports = (grunt) ->
  grunt.registerTask 'server', ['build:once', 'express', 'concurrent:build']