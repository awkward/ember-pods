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

  podResolver: (what) ->
    {type, name} = ResolverHelpers.parse(what)

    # support nested pods
    dashedName = Ember.String.dasherize(name)
    if dashedName.indexOf('-') > -1
      name = dashedName.replace('-', '/')

    # try to resolve
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

    # support nested views
    if name.indexOf('.')
      name = name.replace('.', '/')

    # return ordinary template    
    return Ember.TEMPLATES["app/pods/#{name}/template"]

  modelResolver: (what) ->
    {type, name} = ResolverHelpers.parse(what)

    try
      module = require("models/#{name}")["default"]
      module.toString = -> Ember.String.classify(name)
      return module
    catch e
      return false
    


Resolver = Ember.DefaultResolver.extend
  resolve: (what) ->
    {type, name} = ResolverHelpers.parse(what)

    if ['controller', 'view', 'route'].indexOf(type) > -1
      type = "pod"

    suffix       = "Resolver"
    resolverName = "#{type}#{suffix}"

    if ResolverHelpers[resolverName]?
      resolver = ResolverHelpers[resolverName]
      module   = resolver(what)

      return module if module

    # let ember fix this one
    # Ember.Logger.info "Resolver couldn't find #{what}. Handing it over to Ember"
    return @_super(what)

# fix for ember.data in ember inspector
Ember.Application.initializer
  name: 'container-debug-adapter'
  initialize: (container) ->
    ContainerDebugAdapter = Ember.ContainerDebugAdapter.extend
      canCatalogEntriesByType: (type) -> return true

      # return a list of known models by looping over the requirejs modules starting with models/
      catalogEntriesByType: (type) ->
        entries = requirejs._defined
        types   = Ember.A()

        for key of entries
          if key.substr(0, 'models/'.length) == 'models/'
            types.push(key.substr('models/'.length, key.length))

        return types

    container.register('container-debug-adapter:main', ContainerDebugAdapter)


`export default Resolver`