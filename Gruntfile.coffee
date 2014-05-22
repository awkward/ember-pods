module.exports = (grunt) ->

  grunt.registerTask 'default', ['clean:all', 'coffee', 'transpile', 'emblem', 'compass', 'concat', 'copy', 'clean:js', 'clean:transpiled']
  
  grunt.initConfig

    ###########
    # Housekeeping
    ###########
    clean: 
      all:        'tmp'
      js:         'tmp/js'
      transpiled: 'tmp/transpiled'

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
    compass:
      dist:
        options:
          require: ['sass-globbing']
          sassDir: "app/assets/stylesheets"
          cssDir:  "tmp/build/stylesheets"

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

  
  # autoload any grunt-* tasks installed
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)