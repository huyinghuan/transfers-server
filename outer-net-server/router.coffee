express = require('express')

uuid = require 'uuid'

messageStack = require './message-stack'

router = express.Router()

class Router
  constructor: (@io)->
    @initRouter()

  get: -> router

  handle: (req, resp)->
    copyPropertyArray = ["body", "originalUrl", "headers", "method"]
    id = uuid.v1()
    messageStack.push(id, (statusCode, headers, data)->
      delete headers["content-length"] if headers
      resp.set(headers)
      resp.status(statusCode).send(data)
    )
    data = {}
    data[item] = req[item] for item in copyPropertyArray
    @io.emit('api', id, data)

  initRouter: ->
    self = @
    router.all("/api/*", (req, resp, next)-> self.handle(req,  resp))

module.exports = (io)-> new Router(io)
