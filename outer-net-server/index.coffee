bodyParser = require 'body-parser'
multer = require 'multer'

app = require('express')()
server = require('http').createServer(app)
io = require('socket.io')(server)

config = require './config'
_Router = require('./router')(io)
messageStack = require './message-stack'

server.listen(config.port)

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(multer())

app.use(_Router.get())


io.on('connection', (socket)->
  if socket.handshake.query.token isnt config.token
    return socket.disconnect()

  socket.on('api:response', (mid, statusCode, headers, data)->
    cb = messageStack.pop(mid)
    cb(statusCode, headers, data)
  )
)
