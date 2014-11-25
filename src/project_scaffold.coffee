cli    = require('cli')
fs     = require('fs-extra')
os     = require('os')
{exec} = require('child_process')

class ProjectScaffold
  # general config
  blueprint_directroy:    "#{__dirname}/../blueprint"
  bower_install_command:  "bower install"
  npm_install_command:    "npm install"

  init: (@args, @options, @path) =>
    unless @options.force or @_directoryEmpty(@path)
      cli.fatal("Directory #{@path} is not empty. pass -f or --force to force")

    @_setupStructure()

  new: (@args, @options, @path, name) =>
    @path = "#{@path}/#{name}"
    fs.ensureDir @path, (err) =>
      cli.fatal "Couldn't create directory. #{err}" if err
      process.chdir(@path)
      @_setupStructure()

  # setup basic project structure
  _setupStructure: ->
    cli.spinner("Setting up Astronaut project...")

    fs.copy @blueprint_directroy, @path, (err) =>
      cli.error("Failed setting up project. #{err}") if err
      cli.spinner("Setting up Astronaut project... done", true)
      process.stdout.write(os.EOL)

      # next step: installing NPM dependencies
      @_installNPMDependencies()

  # installing NPM dependencies
  _installNPMDependencies: ->
      cli.spinner("Installing npm dependencies...")
      npm_install = exec @npm_install_command, (error, stdout, stderr) ->
        cli.error "Error install npm dependencies #{error}" if error

      # when done
      npm_install.on 'close', =>
        cli.spinner("Installing npm dependencies... done", true)
        process.stdout.write(os.EOL)
        @_installBowerDependencies()

  # install Bower dependencies
  _installBowerDependencies: ->
    cli.spinner("Install bower dependencies...")
    bower_install = exec @bower_install_command, (error, stdout, stderr) ->
      cli.error "Error install bower dependencies #{error}" if error

    bower_install.on 'close', =>
      cli.spinner("Install bower dependencies... done", true)
      process.stdout.write(os.EOL)
      @_done()

  _done: ->
    cli.ok "Setup succesful, project ready for takeof ;)"

  _directoryEmpty: (path) ->
    fs.readdirSync(path).length == 0

module.exports = new ProjectScaffold