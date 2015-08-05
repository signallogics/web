express = require 'express'
i18n = require 'i18n-2'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
morgan = require 'morgan'
path = require 'path'
debug = require('debug') 'ctfight:express'
fs = require 'fs'

# express configuration

app = express()
app.set 'view engine', 'jade'
app.use express.static 'static'

app.use do cookieParser
app.use do bodyParser.json
app.use bodyParser.urlencoded extended: yes, limit: 100000000

console.log " ----- #{process.env.NODE_ENV} mode ----- "
switch process.env.NODE_ENV
	when 'dev'
		app.use morgan 'dev', devDefaultColor: 90
	when 'production'
		app.use morgan 'combined', stream: fs.createWriteStream __dirname + '/access.log', flags: 'a'


srg = require './storage.coffee'

app.use srg.limitHandler

# localization

i18n.expressBind app,
	locales: ['ru', 'en'],
	cookieName: 'locale'

app.use (req, res, next) ->
	req.i18n.setLocale req.cookies.locale
	do next


# data #

_data = require './data.coffee'

db = require './db.coffee'


# main pages #
app.route ['/', '/index']
	.get (req, res) ->
		res.render 'index', title: req.i18n.__('index_title')
	.post (req, res) ->
		db.teams.addOnlyEmail req.body.email
		res.render 'notification', notification: req.i18n.__('we_notify_you_about_start')


app.route '/request'

	.get (req, res) ->
		db.teams.list (err, teams) ->
			unless err
				if teams.length < 8
					message = req.i18n.__('register_is_open', teams.length)
				else if teams.length < 16
					message = req.i18n.__('register_is_in_next_time', teams.length - 8)
				else
					message = req.i18n.__('register_is_inaccessible')
				res.render 'request', requestForm: _data.requestForm, message: message, title: req.i18n.__('request_title')

	.post (req, res) ->
		db.teams.add req.body, (err) ->
			unless err
				res.render 'notification', notification: req.i18n.__('registration_success')
			else
				# TODO: Write unknown error to logs
				errors =
					UNKNOWN: 'unknown'
					WRONG_EMAIL: 'wrong_email'
					NO_MANDATORY_FIELDS: 'no_mandatory_fields'
				error = errors[err.code] or 'UNKNOWN'
				res.render 'notification', notification: req.i18n.__("registration_failed__#{error}")


app.get '/teams', (req, res) ->
	db.teams.list (err, teams) ->
		unless err
			res.render 'teams', teamsTitle: 'Первый тур', teams: teams.slice(0, 8), title: req.i18n.__('teams_title')


app.post '/upload', srg.upload.single('file'), srg.handler
app.post '/upload/static', srg.uploadImages.single('file'), srg.handler

app.get '/static/*', (req, res) ->
	res.redirect req.path.substr 7

###
# get translation of work with i18n module
# require for front-end
###
app.get '/translation', (req, res) ->
	result =
		text: req.i18n.__(req.query.text)
		locale: req.i18n.locale
	res.send result

# development #

# if running without --production flag
if process.env.NODE_ENV is 'dev'
	jade = require 'jade'

	# jade syntax hightlight with prism.js
	jade.filters.jade = (str) ->
		"<pre><code class=\"language-jade\">#{str}</pre></code>"

	# jade syntax hightlight and html compile with prism.js
	jade.filters.jadelive = (str) ->
		arr = str.split('\n')
		className = arr[0]
		str = arr.slice(1).join('\n')
		"<div class='example'><div class=#{className}>#{ jade.render str }</div><pre><code class=\"language-jade\">#{str}</pre></code>"

	# stylus syntax hightlight with prism.js
	jade.filters.stylus = (str) ->
		"<pre><code class=\"language-stylus\">#{str}</pre></code>"

	# coffee syntax hightlight with prism.js
	jade.filters.coffee = (str) ->
		"<pre><code class=\"language-coffeescript\">#{str}</pre></code>"

	# styleguide page
	app.get '/styl', (req, res) ->
		res.render 'styleguide'


###*
# Expose `app`
###
module.exports = app
