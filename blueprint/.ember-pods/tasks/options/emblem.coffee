########################
# Compile and concatenate *.emblem templates in a single file
########################
module.exports = (grunt) ->
  emblem:
    compile:
      files:
        'tmp/js/templates.js': ['app/**/*.emblem']

      options:
        dependencies:
          jquery:     'bower_components/jquery/dist/jquery.js',
          ember:      'bower_components/ember/ember.js',
          emblem:     'bower_components/emblem/dist/emblem.js',
          handlebars: 'bower_components/handlebars/handlebars.js'