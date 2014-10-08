express = require('express')
app     = express()
path    = require('path')

app.use express.static('tmp/build') 

app.get '*', (req, res) ->
  res.sendFile(path.join(process.cwd(), 'tmp', 'build', 'index.html'))

app.listen(3000)

console.log 'Server runs at port 3000'