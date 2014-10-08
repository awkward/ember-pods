`import startApp from 'support/initializer'`
App = null

module '<%= podName %>',
  setup: ->
    App = startApp()
  teardown: ->
    Ember.run(App, 'destroy')

test '<%= podName %> pod', ->
  ok false, 'unimplemented <%= podName %> integration test'
