module.exports = (grunt) ->
  # grunt - build, watch
  grunt.registerTask 'default', ['build']

  # grunt server - build, watch, livereload and serve using node server
  grunt.registerTask 'server', ['build:once', 'express', 'watch']

  # grunt build - build, watch + livereload
  grunt.registerTask 'build', ['build:once', 'watch']

  # grunt test - setup test files
  grunt.registerTask 'test', ['build:once', 'coffee:test', 'transpile:test', 'concat:test']

  # grunt build:production - build once for production (concatenated, minified, gzipped
  # grunt.registerTask 'build:production', ->
  #   grunt.log.writeln 'Building for production'

  # grunt build:once - Builds all assets only once
  grunt.registerTask 'build:once', ['clean:all', 'coffee', 'transpile', 'emblem', 'stylus', 'concat', 'copy']


  # shorthand method to get all the required *.styl files
  importsCssBundle = () ->
    imports = grunt.file.expand({cwd: "app/assets/stylesheets/imports/"}, '**/*.styl')
    imports.push('nib')
    return imports

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
      test:
        options:
          bare: true
        files:
          grunt.file.expandMapping(['test/**/*.coffee'], 'tmp/js/test/',
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
          src: ['**/*.js', '!helpers/**/*.js'],
          dest: 'tmp/transpiled'
        ]
      test:
        type: 'amd'
        files: [
          expand: true,
          cwd: 'tmp/js/test/',
          src: ['**/*.js'],
          dest: 'tmp/transpiled/test'
        ]

    ###########
    # Concatenate vendor files and app files
    ###########
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

    ###########
    # Compile and concatenate *.styl files
    ###########
    stylus:
      compile:
        options:
          paths: ['app/assets/stylesheets/imports']
          import: importsCssBundle()
        files:
          'tmp/build/stylesheets/main.css':[
            'app/assets/stylesheets/main.styl'
            'app/pods/**/*.styl'
            'app/components/**/*.styl'
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

  # load generator tasks
  grunt.task.loadTasks '.ember-pods'
