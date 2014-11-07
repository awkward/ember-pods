########################
# Compress files for production
########################

module.exports = (grunt) ->
  compress:
    main:
      options:
        mode: 'gzip'
      expand: true
      cwd: 'tmp/prod/'
      src: ['**/*']
      dest: 'tmp/dist/'