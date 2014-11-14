########################
# Minify css for production
########################

module.exports = (gunt) ->
  cssmin:
    main:
      files: 'tmp/prod/stylesheets/main.css': 'tmp/build/**/*.css'