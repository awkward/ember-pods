module.exports = (grunt) ->
  grunt.registerTask 'generate:pod-test', ->
  grunt.log.writeln 'Firing up the pod test generator'

  # sanitize input
  podPrefix     = "test/pods/"
  podName       = grunt.option('name')
  podNameUpper  = podName.toUpperCase()
  podPath       = podName.replace(/\./g, "/")

  # read template files where needed
  controllerContents  = grunt.file.read('.ember-pods/templates/test/pod/controller.coffee')
  routeContents       = grunt.file.read('.ember-pods/templates/test/pod/route.coffee')
  viewContents        = grunt.file.read('.ember-pods/templates/test/pod/view.coffee')

  integrationContents = grunt.file.read('.ember-pods/templates/test/pod/integration.coffee')

  # process templates
  controllerContentsProcessed   = grunt.template.process(controllerContents,    {data: {podName: podName}})
  routeContentsProcessed        = grunt.template.process(routeContents,         {data: {podName: podName}})
  viewContentsProcessed         = grunt.template.process(viewContents,          {data: {podName: podName}})

  integrationContentsProcessed  = grunt.template.process(integrationContents,   {data: {podName: podName}})

  # write templates
  grunt.file.write("#{podPrefix}#{podPath}/controller-test.coffee",   controllerContentsProcessed)
  grunt.file.write("#{podPrefix}#{podPath}/route-test.coffee",        routeContentsProcessed)
  grunt.file.write("#{podPrefix}#{podPath}/view-test.coffee",         viewContentsProcessed)

  grunt.file.write("test/integration/#{podName}-test.coffee",         integrationContentsProcessed)

  grunt.log.writeln "Generated tests for #{podName} pod at location #{podPath}"
