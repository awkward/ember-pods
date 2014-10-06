########################
# Transpile ES6 modules to AMD
########################

module.exports = (grunt) ->
  transpile:
    main:
      type: 'amd'
      files: [
        expand: true,
        cwd: 'tmp/js/',
        src: ['**/*.js', '!helpers/**/*.js'],
        dest: 'tmp/transpiled'
      ]