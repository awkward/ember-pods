cli             = require('cli')
ProjectScaffold = require('./project_scaffold')

class core
  handle: (args, options) =>
    cli.info('CWD:'          + process.cwd())
    cli.info('Command:'      + cli.command)
    cli.info('Environment:'  + options.env)
    cli.info('Args:',        + args.toString())
    cli.info('Options:',       options)

    this[cli.command].call(this, args, options) if this[cli.command]

  new: (args, options) ->
    cli.debug("TODO: generate new project named #{args[0]}")

  init: (args, options) ->
    ProjectScaffold.setup(process.cwd())

  generate: (args, options) ->
    cli.debug("TODO: fire up ol' generator")

  build: (args, options) ->
    cli.debug("TODO: Start build task")

  server: (args, options) ->
    cli.debug("TODO: Start up server")

  test: (args, options) ->
    cli.debug("TODO: fire up the test helper")

# export core
module.exports = new core