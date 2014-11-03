########################
# grunt build - build, watch + livereload
# grunt build:once - Builds all assets only once
########################

module.exports = (grunt) ->

  grunt.registerTask 'build', ['build:once', 'esteWatch']
  grunt.registerTask 'build:once', ['clean:all', 'coffee', 'transpile', 'emblem', 'sass', 'concat', 'copy']

  grunt.registerTask 'test', ['build:once', 'coffee:test', 'transpile:test', 'concat:test']