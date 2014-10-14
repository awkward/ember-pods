module.exports = (grunt) ->
  grunt.registerTask 'generate:component-test', ->
    grunt.log.writeln 'Firing up the component test generator'

    # sanitize input
    componentPrefix     = "test/components/"
    componentName       = grunt.option('name')
    componentNameUpper  = componentName.toUpperCase()
    componentPath       = componentName.replace(/\./g, "/")
    componentTestName   = "#{componentName}-test"

    # read template files where needed
    componentContents   = grunt.file.read('.ember-pods/templates/test/component/component.coffee')

    # process templates
    componentContentsProcessed  = grunt.template.process(componentContents,  {data: {componentName: componentName}})

    # write templates
    grunt.file.write("#{componentPrefix}#{componentPath}/component-test.coffee",       componentContentsProcessed)

    grunt.log.writeln "Generated component test named #{componentTestName} at #{componentPath}"
