express = require 'express'
http = require 'http'
path = require 'path'


app = express()

app.use(express.favicon());
app.use(express.logger('dev'));

# # marker for `grunt-express` to inject static folder/contents
# staticsPlaceholder = (req, res, next) ->
#   next()
# app.use staticsPlaceholder

app.use express.cookieParser()
app.use express.session
  secret: 'recomio sentiment baby'
app.use express.bodyParser()


app.get '/4', (req, res) -> res.send '12345'


module.exports = app
