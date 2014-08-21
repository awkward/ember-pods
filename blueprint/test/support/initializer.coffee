App = require("app")["default"]
App.setupForTesting()
App.ApplicationAdapter = DS.FixtureAdapter.extend()
App.injectTestHelpers()
