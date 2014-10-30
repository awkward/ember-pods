module.exports = (grunt) ->
  grunt.registerTask 'generate:factory', ->
    grunt.log.writeln 'Firing up the factory generator'

    # sanitize input
    factoryPrefix     = "test/factories/"
    factoryName       = "#{grunt.option('name')}"
    factoryNameUpper  = factoryName.toUpperCase()
    factoryPath       = factoryName.replace(/\./g, "/")

    grunt.log.writeln "Generated factory test named  #{factoryName}Factory at #{factoryPath}"

    # read template files where needed
    factoryContents  = grunt.file.read(".ember-pods/templates/test/factory/factory.coffee")

    # process templates
    factoryContentsProcessed = grunt.template.process(factoryContents, {data: {factoryName: factoryName}})

    # write templates
    grunt.file.write("#{factoryPrefix}#{factoryName}Factory.coffee",    factoryContentsProcessed)
