########################
# Bridge the gap between source maps
########################

module.exports = (grunt) ->
  multi_stage_sourcemap:
    es6Coffee:
      filesFrom: 'tmp/transpiled/app/**/*.js.map'
      files: [{
        expand: true
        cwd: 'tmp/js/app/'
        src: ['**/*.js.map']
        dest: 'tmp/transpiled/app'
      }]