########################
# Transpile ES6 modules to AMD
########################

module.exports = (grunt) ->
  transpile:
    main:
      options:
        format: 'amd'
        sourcemaps: true
        base: 'tmp/js/'
      files: [
        expand: true,
        cwd: 'tmp/js/',
        src: ['**/*.js', '!test/**/*.js', '!app/helpers/**/*.js'],
        dest: 'tmp/transpiled'
      ]
    test:
      options:
        format: 'amd'
        sourcemaps: false
        base: 'tmp/js/'
      files: [
        expand: true,
        cwd: 'tmp/js/',
        src: ['**/*.js', '!app/**/*.js'],
        dest: 'tmp/transpiled'
      ]
