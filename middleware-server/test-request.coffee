request = require 'request'

option =
  url: 'http://bhf.hunantv.com/api/account/token'
  method: 'POST'
  formData: {account: '胡瀛寰', password: '888888'}
request(option, (error, resp, body)->
  console.log error
  console.log resp.headers
  console.log body
)