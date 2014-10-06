path = require('path')
fs   = require('fs')

module.exports = (grunt) ->

  # autoload any grunt-* tasks installed
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  # load generator tasks
  grunt.task.loadTasks path.join(process.cwd(), '.ember-pods', 'generators')

  # load external tasks
  grunt.task.loadTasks path.join(process.cwd(), '.ember-pods', 'tasks')

  # load all tasks's configurations
  configsPath = path.join(process.cwd(), '.ember-pods', 'tasks', 'options')
  configFiles = fs.readdirSync(configsPath)

  configFiles.forEach (configFile) ->
    config = require(path.join(configsPath, configFile))
    grunt.config.merge(config(grunt))

  # grunt - build, watch
  grunt.registerTask 'default', ['build']