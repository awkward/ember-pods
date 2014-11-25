path = require('path')
cli  = require('cli')
core = require('../lib/core')

# configure cli
cli.width = 200
cli.enable('version')
cli.parsePackageJson(path.join(__dirname, '..','package.json'))

# publish available options
cli.parse(
    port:               ['p',   'Set the server port', 'number','3000']
    'skip-tests':       [false, 'Skip generating tests when generating application parts']
    'no-live-reload':   [false, 'Don\'t live reload on file changes']
    'force':            ['f',   'Force action']
  ,
    init:       'Initialize new Astronaut project in current directory'
    new:        'Initialize new Astronaut project with given name'
    generate:   'Generate new application part (pod, component, model or helper)'
    build:      'Build sourcefiles to compiled application (e.g. build production)'
    server:     'Start development server'
    test:       'Run application tests'
  )

# handle commands
cli.main(core.handle)