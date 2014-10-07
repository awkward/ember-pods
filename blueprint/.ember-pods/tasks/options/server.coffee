########################
# Spawn a basic development server to serve assets
########################

path = require('path')
module.exports = (grunt) ->
  express:
    dev:
      options:
        opts: ['node_modules/coffee-script/bin/coffee']
        script: path.join(process.cwd(), '.ember-pods', 'scripts', 'server.coffee')