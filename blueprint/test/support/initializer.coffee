App = require("app")["default"]
document.write "<div id=\"ember-testing-container\"><div id=\"ember-testing\"></div></div>"
expect = chai.expect
assert = chai.assert
should = chai.should()
ok = (expr, msg) ->
  throw new Error(msg)  unless expr

chai.config.includeStack = true
App.rootElement = "#ember-testing"
App.setupForTesting()
App.ApplicationAdapter = DS.FixtureAdapter.extend()
App.injectTestHelpers()

# these methods should be defined
start = ->

stop = ->
