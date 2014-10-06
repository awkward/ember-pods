########################
# Spawn a basic development server to serve assets
########################

module.exports = (grunt) ->
  express:
    dev:
      options:
        opts: ['node_modules/coffee-script/bin/coffee']
        script: 'server/server.coffee'