class Message
  constructor: ->
    @stack = {}

  push: (mid, cb)->
    @stack[mid] = cb

  pop: (mid)->
    cb = @stack[mid]
    delete @stack[mid]
    cb

module.exports = new Message()