StoryTestHelper = Ember.Object.createWithMixins FactoryGuyTestMixin,
  setup: (app, opts) ->    
    app.reset()
    $.mockjaxSettings.logging = false
    $.mockjaxSettings.responseTime = 0
    this._super(app)

  teardown: ->
    $.mockjaxClear()
    this._super()

module "Integration test:", ->
  setup: ->
  teardown: ->

test "The first test", ->
  visit "/"
  andThen ->
    equal $("body").length, 1
