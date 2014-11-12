  module.exports = (grunt) ->
    grunt.registerTask 'generate:pod', ->
      grunt.log.writeln 'Firing up the pod generator'

      # sanitize input
      podPrefix     = "app/pods/"
      podName       = grunt.option('name')
      podNameUpper  = podName.toUpperCase()
      podPath       = podName.replace(/\./g, "/")

      # determine CSS class
      cssClass = podName.replace(/\./g,"-")
      cssClass = cssClass.charAt(0).toUpperCase()+cssClass.slice(1)

      # read template files where needed
      stylesheetContents  = grunt.file.read('.ember-pods/templates/pod/stylesheet.sass')
      templateContents    = grunt.file.read('.ember-pods/templates/pod/template.emblem')
      viewContents        = grunt.file.read('.ember-pods/templates/pod/view.coffee')

      # process templates
      stylesheetContentsProcessed = grunt.template.process(stylesheetContents, {data: {podName: podName, cssClass: cssClass}})
      viewContentsProcessed       = grunt.template.process(viewContents,       {data: {podName: podName, cssClass: cssClass}})
      templateContentsProcessed   = grunt.template.process(templateContents,   {data: {podName: podName}})

      # write templates
      grunt.file.write("#{podPrefix}#{podPath}/#{podName}.sass",    stylesheetContentsProcessed)
      grunt.file.write("#{podPrefix}#{podPath}/view.coffee",        viewContentsProcessed)
      grunt.file.write("#{podPrefix}#{podPath}/template.emblem",    templateContentsProcessed)
      grunt.file.copy('.ember-pods/templates/pod/controller.coffee',  podPrefix+podPath+"/controller.coffee")
      grunt.file.copy('.ember-pods/templates/pod/route.coffee',       podPrefix+podPath+"/route.coffee")

      grunt.log.writeln "Generated pod named #{podName} at location #{podPath}"
