module.exports = (grunt) ->

  grunt.registerTask 'default', ['clean', 'coffee', 'transpile', 'emblem', 'sass', 'concat', 'copy']

  grunt.loadNpmTasks 'grunt-es6-module-transpiler'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-emblem'

  grunt.initConfig
    clean: ['tmp']
    coffee:
      compile:
        options:
          bare: true
        files:
          grunt.file.expandMapping(['app/**/*.coffee'], 'tmp/js/',
            rename: (destBase, destPath) ->
              return destBase + destPath.slice(4, destPath.length).replace(/\.coffee$/, '.js')
          )

    transpile:
      main: 
        type: "amd"
        files: [
          expand: true,
          cwd: 'tmp/js/',
          src: ['**/*.js'],
          dest: 'tmp/transpiled'
        ]

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
        dest: 'tmp/build/vendor.js'

      app:
        src: [
          'tmp/js/templates.js',
          'tmp/transpiled/**/*.js'
        ]
        dest:
          'tmp/build/app.js'

    sass:
      dist:
        files: [
          expand: true
          flatten: true
          cwd: 'app/'
          src: ['**/*.sass']
          dest: 'tmp/build/css'
          ext: '.css'
        ]
    

    copy:
      main:
        files: [
            # includes files within path
            expand: true
            flatten: true
            src: ['app/index.html']
            dest: 'tmp/build'
        ]

    emblem:
      compile:
        files:
          'tmp/js/templates.js': ['app/**/*.emblem'] #compile and concat into single file
        
        options:
          dependencies:
            jquery:     'bower_components/jquery/dist/jquery.js',
            ember:      'bower_components/ember/ember.js',
            emblem:     'bower_components/emblem/dist/emblem.js',
            handlebars: 'bower_components/handlebars/handlebars.js'