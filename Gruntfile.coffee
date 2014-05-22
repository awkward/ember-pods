module.exports = (grunt) ->
  require('time-grunt')(grunt)

  # grunt - build, watch
  grunt.registerTask 'default', ['build']

  # grunt server - build, watch, livereload and serve using node server
  # grunt.registerTask 'server', []

  # grunt build - build, watch and livereload
  # TODO: Implement watcher and livereload

  grunt.registerTask 'build', ['build:once', 'watch']

  # grunt build:production - build once for production (concatenated, minified, gzipped)

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
    compass:
      dist:
        options:
          require: ['sass-globbing']
          sassDir: "app/assets/stylesheets"
          cssDir:  "tmp/build/stylesheets"
          environment: 'development'
          outputStyle: 'compressed'

    stylus:
      compile:
        # options:
        #   paths: ['path/to/import', 'another/to/import'],
        #   urlfunc: 'embedurl', #// use embedurl('test.png') in our code to trigger Data URI embedding
        #   use: [
        #     require('fluidity') #// use stylus plugin at compile time
        #   ],
        #   import: [      //  @import 'foo', 'bar/moo', etc. into every .styl file
        #     'foo',       //  that is compiled. These might be findable based on values you gave
        #     'bar/moo'    //  to `paths`, or a plugin you added under `use`
        #   ]
        
        files:
          'tmp/build/stylesheets/main.css': [
            'app/assets/stylesheets/main.styl'
            'app/components/**/*.styl'
            'app/pods/**/*.styl'
          ]
          #'path/to/another.css': ['path/to/sources/*.styl', 'path/to/more/*.styl'] #// compile and concat into single file
      


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
        files: 'app/**/*.sass'
        tasks: ['compass']
        options:
          spawn: false
          livereload: true
  
  # autoload any grunt-* tasks installed
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)