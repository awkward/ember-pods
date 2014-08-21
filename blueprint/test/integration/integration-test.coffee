module "Integration test:", ->
  setup: ->
    Ember.run ->
      App.reset()

test "The first test", ->
  visit "/"
  andThen ->
    equal $("body").length, 1
