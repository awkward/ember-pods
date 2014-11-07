########################
# Minify images for production
########################

module.exports = (gunt) ->
  imagemin:
    main:
      cwd: 'tmp/prod/'
      files:[
        src: ['**/*.{png,jpg,gif}']
        dest: 'tmp/dist/'
      ]