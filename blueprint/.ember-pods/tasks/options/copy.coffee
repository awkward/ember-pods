########################
# Copy static files over
########################

module.exports = (grunt) ->
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
    prod:
      expand: true
      cwd: 'tmp/build/assets/'
      src: ['**/*.{png,jpg,jpeg,gif}']
      dest: 'tmp/prod/assets/'