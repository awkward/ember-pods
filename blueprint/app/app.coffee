`import Resolver from 'resolver';`

App = Ember.Application.create
  modulePrefix: 'ember-starter'
  Resolver:     Resolver

App.ApplicationStore = DS.Store.extend()

`export default App`