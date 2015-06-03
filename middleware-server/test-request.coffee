request = require 'request'

request.post(
  "https://bhf.hunantv.com/api/account/token",
  {form: {account: "胡瀛寰", password: "8888888"}},
  (error, resp, body)->
    console.log error
    console.log resp.statusCode
    console.log body
)