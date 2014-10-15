cli = require('cli')
# path = require('path')
fs = require('fs')
class ProjectScaffold

  setup: (path) ->

    if !@directoryEmpty(path)
      cli.error('Directory ' + path + ' is not empty. pass -f or --force to force')
      return

      cli.info('Setting up project in ' + path)
      cli.info('path empty?' + @directoryEmpty(path))


    # console.log 'Installing dependencies...'
    # exec 'npm install grunt', (err) ->
    #   return console.log err if err
    #   exec "cp -r #{__dirname}/blueprint/* #{process.cwd()} && cp -r #{__dirname}/blueprint/.ember-pods #{process.cwd()}", (err) ->
    #     return console.log err if err
    #     exec "npm install && bower install", (err) ->
    #       return console.log err if err
    #       console.log 'Created new project'

  directoryEmpty: (path) ->
    fs.readdirSync(path).length == 0

module.exports = new ProjectScaffold