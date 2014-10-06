########################
# Compile Coffee to JS
########################

module.exports = (grunt) ->
  coffee:
    compile:
      options:
        bare: true
      files:
        grunt.file.expandMapping(['app/**/*.coffee'], 'tmp/js/',
          rename: (destBase, destPath) ->
            return destBase + destPath.slice(4, destPath.length).replace(/\.coffee$/, '.js')
        )