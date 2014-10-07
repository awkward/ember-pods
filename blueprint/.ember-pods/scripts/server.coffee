express = require('express')
app     = express()

app.use express.static('tmp/build') 

app.get '*', (req, res) ->
  res.sendfile('tmp/build/index.html')

app.listen(3000)

console.log 'Server runs at port 3000'