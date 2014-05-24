module.exports = (grunt) ->
  grunt.registerTask 'generate:model', ->
    grunt.log.writeln 'Firing up the model generator'

    # sanitize input
    modelPrefix     = "app/models/"
    modelName       = grunt.option('name')
    modelNameUpper  = modelName.toUpperCase()
    modelPath       = modelName.replace(".", "/")

    # copy model template
    grunt.file.copy("generator/templates/model/model.coffee" ,"#{modelPrefix}#{modelName}.coffee")

    grunt.log.writeln "Generated model named  #{modelName} at #{modelPath}"