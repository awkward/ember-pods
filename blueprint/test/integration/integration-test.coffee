`import startApp from 'support/initializer'`
App = null

module "test",
  setup: ->
    App = startApp()
  teardown: ->
    Ember.run(App, 'destroy')

module "Integration test:", ->
  setup: ->
  teardown: ->

test "The first test", ->
  visit "/"
  andThen ->
    equal $("body").length, 1
