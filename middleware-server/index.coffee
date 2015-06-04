request = require 'request'

config = require './config'

socket = require('socket.io-client')(config.remote, {query: "token=#{config.token}"})

socket.on('connect', ()->
  console.log "connected server #{config.remote}"
)

getRequestOption = (data)->
  if (not data.headers["x-token"]) and config.isDev
    data.headers["x-token"] = "03051ba4-9ec9-49c7-bfc6-2dd11cc7e74d"

  data.headers["host"] = config.target_server_host

  option =
    url: "#{config.target_server}#{data.originalUrl}"
    method: data.method
    headers:
      host: data.headers.host
      "x-token": data.headers["x-token"]
      "content-type": data.headers["content-type"]

  if data.method isnt 'GET'
    option.formData = data.body

  option

socket.on('api', (mid, data)->
  options = getRequestOption(data)
  request(options, (error, resp, body)->
    if(error)
      socket.emit("api:response", mid, 500, body)
    else
      socket.emit("api:response", mid, resp.statusCode, resp.headers ,body)
  )
)
