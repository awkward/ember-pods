cli             = require('cli')
ProjectScaffold = require('./project_scaffold')

class core
  handle: (args, options) =>
    this[cli.command].call(this, args, options) if this[cli.command]

  new: (args, options) ->
    ProjectScaffold.new(args, options, process.cwd(), args[0])

  init: (args, options) ->
    ProjectScaffold.init(args, options, process.cwd())

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