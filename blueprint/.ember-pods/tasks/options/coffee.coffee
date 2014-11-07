########################
# Compile Coffee to JS
########################

module.exports = (grunt) ->
  coffee:
    compile:
      options:
        bare: true
        sourceMap: true
      expand: true
      cwd: 'app'
      src: ['**/*.coffee']
      dest: 'tmp/js/app/'
      ext: '.js'
    test:
      options:
        bare: true
      expand: true
      cwd: 'test'
      src: ['**/*.coffee']
      dest: 'tmp/js/test/'
      ext: '.js'