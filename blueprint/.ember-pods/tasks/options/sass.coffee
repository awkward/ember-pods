########################
# Compile and concatenate *.sass files
########################

# shorthand method to get all the required *.sass files
importsCssBundle = (grunt) ->
  imports = grunt.file.expand({cwd: "app/assets/stylesheets/imports/"}, '**/*.sass')
  return imports

module.exports = (grunt) ->
  sass:
    compile:
      options:
        includePaths: [
          require('node-bourbon').includePaths
          'app/assets/stylesheets/imports/'
          'bower_components/bootstrap-sass-twbs/assets/stylesheets/'
        ].concat(importsCssBundle(grunt))
      files:
        'tmp/build/stylesheets/main.css': 'app/assets/stylesheets/main.sass'