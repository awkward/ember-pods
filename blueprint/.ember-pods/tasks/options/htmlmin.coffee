########################
# Minify html for production
########################

module.exports = (gunt) ->
  htmlmin:
    main:
      options:
        collapseWhitespace: true
        removeComments: true
        removeWhitespace: true
      files:
        'tmp/prod/index.html': 'tmp/build/index.html'