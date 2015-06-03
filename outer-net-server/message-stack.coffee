class Message
  constructor: ->
    @stack = {}

  push: (mid, cb)->
    @stack[mid] = cb

  pop: (mid)-> @stack[mid]

module.exports = new Message()