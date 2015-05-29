bodyParser = require 'body-parser'
multer = require 'multer'

app = require('express')()
server = require('http').createServer(app)
io = require('socket.io')(server)

config = require './config'
_Router = require('./router')(io)

server.listen(config.port)

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(multer())

app.use(_Router.get())


io.on('connection', (socket)->
  if socket.handshake.query.token isnt config.token
    return socket.disconnect()
)