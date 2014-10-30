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
        extensions: ['coffee', 'styl', 'emblem']
        enabled: true
    'coffee': (filepath) -> ['coffee', 'transpile', 'concat:app']
    'emblem': (filepath) -> ['emblem', 'concat:app']
    'styl': (filepath) -> ['stylus']
