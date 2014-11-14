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
    'coffee': (filepath) -> ['coffee', 'transpile', 'multi_stage_sourcemap', 'concat_sourcemap:app', 'concat_sourcemap:test', 'shell:karma']
    'emblem': (filepath) -> ['emblem', 'transpile', 'multi_stage_sourcemap', 'concat_sourcemap:app', 'concat_sourcemap:test', 'shell:karma']
    'sass': (filepath) -> ['styles']

  shell:
    karma:
      command: 'karma run'
