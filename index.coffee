express = require 'express'

# express configuration

app = express()
app.set('views', 'static/views');
app.set 'view engine', 'jade'
app.use express.static __dirname + '/static'


# logger
app.use (req, res, next) ->
	console.log "#{req.method} #{req.url}"
	do next


# main pages #

app.get ['/', '/index'], (req, res) ->
	res.render 'index'

app.get '/request', (req, res) ->
	res.render 'request'

app.get '/teams', (req, res) ->
	res.render 'teams'


# development #

jade = require 'jade'

jade.filters.jade = (str) ->
	"<pre><code class=\"language-jade\">#{str}</pre></code>"

jade.filters.stylus = (str) ->
	"<pre><code class=\"language-stylus\">#{str}</pre></code>"

jade.filters.coffee = (str) ->
	"<pre><code class=\"language-coffeescript\">#{str}</pre></code>"

app.get '/styl', (req, res) ->
	res.render 'styleguide'


# launch server #
_server = app.listen 5000, ->
	console.log 'Listening on port 5000'
