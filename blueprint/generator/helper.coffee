module.exports = (grunt) ->
  grunt.registerTask 'generate:helper', ->
    grunt.log.writeln 'Firing up the helper generator'

    # sanitize input
    helperPrefix     = "app/helpers/"
    helperName       = grunt.option('name')
    helperNameUpper  = helperName.toUpperCase()

    # read the helper template
    helperContents  = grunt.file.read('generator/templates/helper/helper.coffee')
    
    # parse the helper template
    helperContentsProcessed = grunt.template.process(helperContents, {data: {helperName: helperName}})

    # write the new helper
    grunt.file.write("#{helperPrefix}/#{helperName}.coffee",    helperContentsProcessed)

    grunt.log.writeln "Generated helper named  #{helperName}"