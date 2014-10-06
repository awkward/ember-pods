########################
# grunt build - build, watch + livereload
# grunt build:once - Builds all assets only once
########################

module.exports = (grunt) ->
  grunt.registerTask 'build', ['build:once', 'watch']
  grunt.registerTask 'build:once', ['clean:all', 'coffee', 'transpile', 'emblem', 'stylus', 'concat', 'copy']