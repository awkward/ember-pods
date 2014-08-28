`import Resolver from 'resolver';`

App = Ember.Application.create
  ApplicationStore: DS.Store.extend()
  modulePrefix: 'ember-starter'
  Resolver:     Resolver

`export default App`
