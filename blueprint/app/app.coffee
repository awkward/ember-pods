`import Resolver from 'resolver';`

App = Ember.Application.extend
  ApplicationStore: DS.Store.extend()
  modulePrefix: 'ember-starter'
  Resolver:     Resolver

`export default App`
