# Karma configuration
module.exports = (config) ->
  config.set
    
    # Base path that will be used to resolve files and exclude.
    basePath: ""
    
    # Testing framework to be used, default is `jasmine`.
    frameworks: ["qunit"]

    plugins: [
      'karma-qunit'
      'karma-coverage'
      'karma-coffee-preprocessor'
      'karma-chrome-launcher'
      'karma-phantomjs-launcher'
    ]
    
    # List of files / patterns to load in the browser.
    files: [
      "tmp/build/script/vendor.js"
      "tmp/build/script/app.js"

      "node_modules/faker/faker.js"
      "bower_components/ember-data-factory-guy/dist/ember-data-factory-guy.js"
      "test/factories/*.coffee"

      "test/support/*.coffee"
      "test/integration/*.coffee"
      "test/unit/*.coffee"
    ]
    preprocessors:
      "**/*.coffee": ["coffee"]
      'tmp/build/script/app.js': ['coverage']

    coverageReporter:
      type: 'html'
      dir: './test/coverage'

    # List of files to exclude.
    exclude: []
    
    # Test results reporter to use.
    # Possible values: 'dots', 'progress', 'junit'
    reporters: ["progress", "coverage"]
    
    # Web server port.
    port: 9876
    
    # Cli runner port.
    runnerPort: 9100
    
    # Enable / disable colors in the output (reporters and logs).
    colors: true
    
    # Level of logging. Possible values are:
    #
    # * LOG_DISABLE
    # * LOG_ERROR
    # * LOG_WARN
    # * LOG_INFO
    # * LOG_DEBUG
    logLevel: config.LOG_INFO
    
    # Enable / disable watching files and executing tests whenever any of them
    # changes.
    autoWatch: true
    
    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ["PhantomJS"]
    
    # If the browser does not capture in the given timeout [ms], then kill it.
    captureTimeout: 60000
    
    # Continuous Integration mode.
    # If it's `true`, then it captures browsers, runs the tests and exits.
    singleRun: false
