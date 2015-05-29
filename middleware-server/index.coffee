config = require './config'


socket = require('socket.io-client')(config.remote, {query: "token=#{config.token}"})

socket.on('connect', ()->
  console.log "connected server #{config.remote}"
)

socket.on('api', (data)->
  console.log 'accept data', data
)