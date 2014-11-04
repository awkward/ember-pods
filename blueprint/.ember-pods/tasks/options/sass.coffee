########################
# Compile and concatenate *.sass files
########################

module.exports = (grunt) ->
  sass:
    compile:
      options:
        includePaths: [
          require('node-bourbon').includePaths
          'app/assets/stylesheets/imports/'
          'bower_components/bootstrap-sass-twbs/assets/stylesheets/'
        ]
        expand: true
      files:
        'tmp/build/stylesheets/main.css': [
          'app/assets/stylesheets/main.sass'
        ]
  sass_include:
    pods:
      files: "app/assets/stylesheets/imports/_pods.sass":"app/pods/**/*.sass"