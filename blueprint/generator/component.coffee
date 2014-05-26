module.exports = (grunt) ->
  grunt.registerTask 'generate:component', ->
    grunt.log.writeln 'Firing up the component generator'

    # sanitize input
    componentPrefix     = "app/components/"
    componentName       = grunt.option('name')
    componentNameUpper  = componentName.toUpperCase()
    componentPath       = componentName.replace(".", "/")

    # determine CSS class
    cssClass = componentName.replace(".","-")
    cssClass = cssClass.charAt(0).toUpperCase()+cssClass.slice(1)
    
    # read template files where needed
    stylesheetContents  = grunt.file.read('generator/templates/component/stylesheet.styl')
    templateContents    = grunt.file.read('generator/templates/component/template.emblem')
    componentContents   = grunt.file.read('generator/templates/component/component.coffee')

    # process templates
    stylesheetContentsProcessed = grunt.template.process(stylesheetContents, {data: {componentName: componentName, cssClass: cssClass}})
    componentContentsProcessed  = grunt.template.process(componentContents,  {data: {componentName: componentName, cssClass: cssClass}})
    templateContentsProcessed   = grunt.template.process(templateContents,   {data: {componentName: componentName}})

    # write templates
    grunt.file.write("#{componentPrefix}#{componentPath}/#{componentName}.styl",  stylesheetContentsProcessed)
    grunt.file.write("#{componentPrefix}#{componentPath}/template.emblem",        templateContentsProcessed)
    grunt.file.write("#{componentPrefix}#{componentPath}/component.coffee",       componentContentsProcessed)

    grunt.log.writeln "Generated component named  #{componentName} at #{componentPath}"