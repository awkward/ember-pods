`import Resolver from 'resolver';`

App = Ember.Application.create
  Store:        DS.Store.extend()
  modulePrefix: 'ember-starter'
  Resolver:     Resolver

`export default App`