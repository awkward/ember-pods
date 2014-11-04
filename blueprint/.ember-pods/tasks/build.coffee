########################
# grunt build - build, watch + livereload
# grunt build:once - Builds all assets only once
########################

module.exports = (grunt) ->

  grunt.registerTask 'styles', ['sass_include', 'sass']
  grunt.registerTask 'build:once', ['clean:all', 'coffee', 'transpile', 'emblem', 'styles', 'concat', 'copy']
  grunt.registerTask 'build', ['build:once', 'esteWatch']
  grunt.registerTask 'build:prod', ['build:once', 'copy:prod', 'uglify', 'cssmin', 'htmlmin', 'compress']
