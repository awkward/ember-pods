########################
# Concatenate vendor files and app files
########################

module.exports = (grunt) ->
  concat:
    options:
      separator: ';'
    vendor:
      src: [
          'bower_components/almond/almond.js'
          'bower_components/jquery/dist/jquery.js'
          'bower_components/handlebars/handlebars.runtime.js'
          'bower_components/ember/ember.js'
          'bower_components/ember-data/ember-data.js'
        ]
      dest: 'tmp/build/script/vendor.js'

    app:
      src: [
        'tmp/js/templates.js',
        'tmp/js/helpers/**/*.js'
        'tmp/transpiled/**/*.js'
      ]
      dest:
        'tmp/build/script/app.js'