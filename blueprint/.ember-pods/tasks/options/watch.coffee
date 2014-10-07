########################
# Watch CoffeeScript, Stylus and templates for changes
########################

module.exports = (grunt) ->
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