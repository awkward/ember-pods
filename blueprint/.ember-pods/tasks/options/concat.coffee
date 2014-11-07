########################
# Concatenate vendor files and app files
########################

module.exports = (grunt) ->
  concat_sourcemap:
    vendor:
      files: 'tmp/build/script/vendor.js' : [
          'bower_components/loader/loader.js'
          'bower_components/jquery/dist/jquery.js'
          'bower_components/handlebars/handlebars.runtime.js'
          'bower_components/ember/ember.js'
          'bower_components/ember-data/ember-data.js'
        ]

    app:
      options:
        sourceMap: true
        sourcesContent: true
      files: 'tmp/build/script/app.js' : [
        'tmp/js/templates.js',
        'tmp/transpiled/app/**/*.js'
        '!tmp/transpiled/test/**/*.js'
      ]

    test:
      files: 'tmp/build/script/tests.js' : [
        'bower_components/ember-qunit/dist/globals/main.js'
        'bower_components/ember-data-factory/dist/ember-data-factory-1.0.amd.js'
        'tmp/transpiled/test/**/*.js'
      ]