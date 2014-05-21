`import Resolver from 'resolver';`

#ApplicationAdapter = DS.RESTAdapter.extend
#  host: 'http://localhost'
#  namespace: 'api/v1'

Store = DS.Store.extend()

App = Ember.Application.create
  Store:        Store
  modulePrefix: 'ember-starter'
  Resolver:     Resolver


`export default App`