express = require 'express'
i18n = require 'i18n-2'
cookieParser = require 'cookie-parser'

# express configuration

app = express()
app.set('views', 'static/views');
app.set 'view engine', 'jade'
app.use express.static __dirname + '/static'

app.use do cookieParser

# localization

i18n.expressBind app,
	locales: ['en', 'ru'],
	defaultLocale: 'ru'
	cookieName: 'locale'

app.use (req, res, next) ->
	req.i18n.setLocale req.cookies.locale
	do next


# logger
app.use (req, res, next) ->
	console.log "#{req.method} #{req.url}"
	do next

# data #

_data = require './data.coffee'

# main pages #

app.get ['/', '/index'], (req, res) ->
	res.render 'index', title: req.i18n.__('index_title')

app.route '/request'
	.get (req, res) ->
		res.render 'request', requestForm: _data.requestForm, title: req.i18n.__('request_title')
	.post (req, res) ->
		res.redirect 'index'

app.get '/teams', (req, res) ->
	res.render 'teams', teamsTitle: 'Первый тур', teams: _data.teams, title: req.i18n.__('teams_title')


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
