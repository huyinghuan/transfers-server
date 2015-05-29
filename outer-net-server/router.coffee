express = require('express')


class Router
  constructor: (@io)->
    @initRouter()

  get: ->
    @router

  initRouter: ->
    io = @io

    @router = express.Router()

    @router.all("/api/*", (req, resp, next)->
      console.log req.path
      next()
    )



module.exports = (io)-> new Router(io)
