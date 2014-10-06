`import Application from 'app';`
`import Router from 'router';`
`import Resolver from 'resolver';`

# Using globals...for now
emq.globalize()

startApp = (attrs = {}) ->
  App = null
  Router.reopen
    location: 'none'
  Ember.run ->
    App = Application.create(attrs)
    App.ApplicationAdapter = DS.RESTAdapter.extend()
    App.setupForTesting()
    App.injectTestHelpers()

  App.reset()

  return App

setResolver(Resolver.create());

`export default startApp`
