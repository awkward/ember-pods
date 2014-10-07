module.exports = (grunt) ->
  grunt.registerTask 'generate:partial', ->
    grunt.log.writeln 'Firing up the partial generator'

    # sanitize input
    partialPrefix     = "app/partials/"
    partialName       = grunt.option('name')

    # read the partial template
    partialContents  = grunt.file.read('.ember-pods/templates/partial/partial.emblem')

    # parse the partial template
    partialContentsProcessed = grunt.template.process(partialContents, {data: {partialName: partialName}})

    # write the new partial
    grunt.file.write("#{partialPrefix}/_#{partialName}.emblem",    partialContentsProcessed)
