########################
# Concatenate vendor files and app files
########################

module.exports = (grunt) ->
  concat:
    options:
      separator: ';'
    vendor:
      src: [
          'bower_components/loader/loader.js'
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

    test:
      src: [
        'bower_components/ember-qunit/dist/globals/main.js'
        'bower_components/ember-data-factory/dist/ember-data-factory-1.0.amd.js'
        'tmp/transpiled/test/**/*.js'
      ]
      dest:
        'tmp/build/script/tests.js'