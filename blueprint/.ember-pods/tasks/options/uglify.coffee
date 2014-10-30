########################
# Uglify javascript for production
########################

module.exports = (grunt) ->
  uglify:
    main:
      options:
        compress: true
      files:
        'tmp/prod/script/app.prod.js': [
          'bower_components/loader/loader.js'
          'bower_components/jquery/dist/jquery.js'
          'bower_components/handlebars/handlebars.runtime.js'
          'bower_components/ember/ember.prod.js'
          'bower_components/ember-data/ember-data.prod.js'
          'tmp/build/script/app.js'
        ]
