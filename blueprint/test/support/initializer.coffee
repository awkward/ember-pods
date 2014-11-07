`import Application from 'app/app';`
`import Router from 'app/router';`
`import Resolver from 'app/resolver';`

document.write '<div id="ember-testing-container"><div id="ember-testing"></div></div>'

# Using globals...for now
emq.globalize()

startApp = (attrs = {}) ->

  attrs['rootElement'] = "#ember-testing"

  App = null

  Router.reopen
    location: 'none'
  Ember.run ->
    App = Application.create(attrs)
    App.setupForTesting()
    App.injectTestHelpers()

  App.reset()

  return App

setResolver(Resolver.create());

`export default startApp`
