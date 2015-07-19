express = require 'express'

app = express()
app.set('views', 'static/views');
app.set 'view engine', 'jade'
app.use express.static __dirname + '/static'

# logger
app.use (req, res, next) ->
	console.log "#{req.method} #{req.url}"
	do next


app.get ['/', '/index'], (req, res) ->
	res.render 'index'

app.get '/request', (req, res) ->
	res.render 'request'

app.get '/teams', (req, res) ->
	res.render 'teams'


_server = app.listen 5000, ->
	console.log 'Listening on port 5000'
