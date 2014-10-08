module.exports = (grunt) ->
  grunt.registerTask 'generate:model-test', ->
    grunt.log.writeln 'Firing up the model-test generator'

    # sanitize input
    modelPrefix     = "test/models/"
    modelName       = "#{grunt.option('name')}"
    modelNameUpper  = modelName.toUpperCase()
    modelPath       = modelName.replace(/\./g, "/")
    modelTestName       = "#{grunt.option('name')}-test"

    grunt.log.writeln "Generated model test named  #{modelName} at #{modelPath}"

    # read template files where needed
    modelTestContents  = grunt.file.read(".ember-pods/templates/test/model/model.coffee")

    # process templates
    modelTestContentsProcessed = grunt.template.process(modelTestContents, {data: {modelName: modelName}})

    # write templates
    grunt.file.write("#{modelPrefix}#{modelTestName}.coffee",    modelTestContentsProcessed)
