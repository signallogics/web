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

# data #

teams = [
	name: 'keva'
	logo: 'http://keva.su/uploads/2013/11/keva.png'
	info: 'Томск, ТУСУР'
,
	name: 'Команда'
	logo: undefined
	info: 'Новосибирск, НовГУ'
,
	name: 'Команда 2'
	logo: undefined
	info: 'Москва, МГУ'
]

# main pages #

app.get ['/', '/index'], (req, res) ->
	res.render 'index'

app.get '/request', (req, res) ->
	res.render 'request'

app.get '/teams', (req, res) ->
	res.render 'teams', teamsTitle: 'Первый тур', teams: teams


# development #

jade = require 'jade'

jade.filters.jade = (str) ->
	"<pre><code class=\"language-jade\">#{str}</pre></code>"

jade.filters.jadelive = (str) ->
	arr = str.split('\n')
	className = arr[0]
	str = arr.slice(1).join('\n')
	"<div class='example'><div class=#{className}>#{ jade.render str }</div><pre><code class=\"language-jade\">#{str}</pre></code>"

jade.filters.stylus = (str) ->
	"<pre><code class=\"language-stylus\">#{str}</pre></code>"

jade.filters.coffee = (str) ->
	"<pre><code class=\"language-coffeescript\">#{str}</pre></code>"

app.get '/styl', (req, res) ->
	res.render 'styleguide'


# launch server #
_server = app.listen 5000, ->
	console.log 'Listening on port 5000'
