`import startApp from 'support/initializer'`
App = null

module "test",
  setup: ->
    App = startApp()
  teardown: ->
    Ember.run(App, 'destroy')

test "The first test", ->
  visit "/"
  andThen ->
    equal $("body").length, 1
