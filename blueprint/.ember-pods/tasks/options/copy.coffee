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