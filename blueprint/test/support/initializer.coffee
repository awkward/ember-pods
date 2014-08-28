App = require("app")["default"]
App.setupForTesting()
App.injectTestHelpers()

exists = (selector) ->
  !!find(selector).length
stubEndpointForHttpRequest = (url, json) ->
  $.mockjax
    url: url
    dataType: "json"
    responseText: json
$.mockjaxSettings.logging = false
$.mockjaxSettings.responseTime = 0
