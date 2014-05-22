module.exports = (grunt) ->
  # grunt - build, watch
  grunt.registerTask 'default', ['build']

  # grunt server - build, watch, livereload and serve using node server
  grunt.registerTask 'server', ['build:once', 'express', 'watch']

  # grunt build - build, watch + livereload
  grunt.registerTask 'build', ['build:once', 'watch']

  # grunt build:production - build once for production (concatenated, minified, gzipped
  # grunt.registerTask 'build:production', ->
  #   grunt.log.writeln 'Building for production'

  # grunt build:once - Builds all assets only once
  grunt.registerTask 'build:once', ['clean:all', 'coffee', 'transpile', 'emblem', 'stylus', 'concat', 'copy']


  ################
  # Configure tasks
  ################
  grunt.initConfig

    ###########
    # Housekeeping
    ###########
    clean: 
      all: 'tmp'

    ###########
    # Compile Coffee to JS
    ###########
    coffee:
      compile:
        options:
          bare: true
        files:
          grunt.file.expandMapping(['app/**/*.coffee'], 'tmp/js/',
            rename: (destBase, destPath) ->
              return destBase + destPath.slice(4, destPath.length).replace(/\.coffee$/, '.js')
          )
    
    ###########
    # Transpile ES6 modules to AMD
    ###########
    transpile:
      main: 
        type: 'amd'
        files: [
          expand: true,
          cwd: 'tmp/js/',
          src: ['**/*.js'],
          dest: 'tmp/transpiled'
        ]

    ###########
    # Concatenate vendor files and app files
    ###########
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
          'tmp/transpiled/**/*.js'
        ]
        dest:
          'tmp/build/script/app.js'

    ###########
    # Compile and concatenate *.sass files
    ###########
    stylus:
      compile:
        files:
          'tmp/build/stylesheets/main.css': [
            'app/assets/stylesheets/main.styl'
            'app/components/**/*.styl'
            'app/pods/**/*.styl'
          ]

    ###########
    # Copy static files over
    ###########
    copy:
      main:
        files: [
          expand:  true
          flatten: true
          src:     ['app/index.html']
          dest:    'tmp/build'
        ]
      assets:
        expand: true
        cwd: 'app/assets/'
        src: ['**/*', '!stylesheets/main.sass']
        dest: 'tmp/build/assets/'

    ###########
    # Compile and concatenate *.emblem templates in a single file
    ###########
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
    
    ###########
    # Watch CoffeeScript, Stylus and templates for changes
    ###########
    watch:
      scripts:
        files: 'app/**/*.coffee'
        tasks: ['newer:coffee', 'transpile', 'concat:app']
        options:
          spawn: false
          livereload: true

      templates:
        files: 'app/**/*.emblem'
        tasks: ['newer:emblem', 'concat:app']
        options:
          spawn: false
          livereload: true

      stylesheets:
        files: 'app/**/*.styl'
        tasks: ['stylus']
        options:
          spawn: false
          livereload: true

    ###########
    # Spawn a basic development server to serve assets
    ###########
    express:
      dev:
        options:
          opts: ['node_modules/coffee-script/bin/coffee']
          script: 'server/server.coffee'
    
  
  # autoload any grunt-* tasks installed
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)