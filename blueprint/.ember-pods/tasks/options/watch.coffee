########################
# Watch CoffeeScript, Stylus and templates for changes
########################

module.exports = (grunt) ->
  esteWatch:
    options:
      dirs: [
        './app/**'
        './test/**'
        '!./test/coverage/**'
      ]
      livereload:
        extensions: ['coffee', 'sass', 'emblem']
        enabled: true
    'coffee': (filepath) -> ['coffee', 'transpile', 'concat:app']
    'emblem': (filepath) -> ['emblem', 'concat:app']
    'sass': (filepath) -> ['styles']
