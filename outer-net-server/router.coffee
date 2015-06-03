express = require('express')

uuid = require 'uuid'

messageStack = require './message-stack'

class Router
  constructor: (@io)->
    @initRouter()

  get: ->
    @router

  handle: (req, resp)->
    copyPropertyArray = ["body", "originalUrl", "headers", "method"]
    id = uuid.v1()
    messageStack.push(id, (statusCode, data)->
      resp.status(statusCode)
      resp.send(data)
    )
    data = {}
    data[item] = req[item] for item in copyPropertyArray
    @io.emit('api', id, data)

  initRouter: ->
    self = @
    @router = express.Router()
    @router.all("/api/*", (req, resp, next)-> self.handle(req,  resp))

module.exports = (io)-> new Router(io)
