`import Resolver from 'app/resolver';`

App = Ember.Application.extend
  ApplicationStore: DS.Store.extend()
  modulePrefix: 'ember-starter'
  Resolver:     Resolver

`export default App`
