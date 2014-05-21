ResolverHelpers =
  # parse structures like router:main and route:application
  parse: (what) ->
    parts = what.split(':')
    return {
      type: parts[0]
      name: parts[1]
    }

  # resolve different parts of the app like routes, router, controllers..
  routerResolver: (what) ->
    return require('router')["default"]

  multiResolver: (what) ->
    {type, name} = ResolverHelpers.parse(what)
    try
      module = require("pods/#{name}/#{type}")
      return module["default"]
    catch e
      return false

  componentResolver: (what) ->
    {type, name} = ResolverHelpers.parse(what)
    try
      module = require("components/#{name}/component")
      return module["default"]
    catch e
      return false

  templateResolver: (what) ->
    {type, name} = ResolverHelpers.parse(what)

    # looking for component?
    if name.substring(0, 11) is "components/"
      componentName = name.substring(11, name.length)
      return Ember.TEMPLATES["app/components/#{componentName}/template"]

    # return ordinary template    
    return Ember.TEMPLATES["app/pods/#{name}/template"]


Resolver = Ember.DefaultResolver.extend
  resolve: (what) ->
    {type, name} = ResolverHelpers.parse(what)

    if ['controller', 'view', 'route'].indexOf(type) > -1
      type = "multi"

    suffix       = "Resolver"
    resolverName = "#{type}#{suffix}"

    if ResolverHelpers[resolverName]?
      resolver = ResolverHelpers[resolverName]
      module   = resolver(what)

      return module if module

    # let ember fix this one
    #console.info 'Couldn\'t resolve: ' + what
    return @_super(what)

`export default Resolver`