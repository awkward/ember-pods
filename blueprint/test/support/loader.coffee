window.Factory = require 'factory'

for entry of require.entries
  require entry if /-test/.test entry
