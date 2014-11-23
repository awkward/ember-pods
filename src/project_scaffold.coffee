cli    = require('cli')
fs     = require('fs')
{ncp}  = require('ncp')
{exec} = require('child_process')

class ProjectScaffold
  setup: (path) ->
    if !@directoryEmpty(path)
      cli.error("Directory #{path} is not empty. pass -f or --force to force")
      return

    blueprint_directroy = "#{__dirname}/../blueprint"
    cli.spinner("Setting up Astronaut project...")

    ncp blueprint_directroy, path, (err) ->

      cli.error("Failed setting up project. #{err}") if err
      cli.spinner("Setting up Astronaut project...", true)

      # running the npm install command
      cli.spinner("Installing npm dependencies...")
      npm_install = exec "npm install", (error, stdout, stderr) ->
        cli.error "Error install npm dependencies #{error}" if error

      # pipe output when --verbose is passed
      npm_install.stdout.on 'data', (data) ->
        cli.info data

      # when done
      npm_install.on 'close', ->
        cli.spinner("Installing npm dependencies... DONE", true)
        
        cli.spinner("Install bower dependencies...")
        bower_install = exec "bower install", (error, stdout, stderr) ->
          cli.error "Error install bower dependencies #{error}" if error

        bower_install.on 'close', ->
          cli.spinner("Install bower dependencies...DONE", true)


  directoryEmpty: (path) ->
    fs.readdirSync(path).length == 0

module.exports = new ProjectScaffold