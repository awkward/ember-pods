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
        includePaths: [require('node-bourbon').includePaths].concat('app/assets/stylesheets/imports').concat(importsCssBundle(grunt))
      files:
        'tmp/build/stylesheets/main.css':[
          'app/assets/stylesheets/main.sass'
          'app/pods/**/*.sass'
          'app/components/**/*.sass'
        ]