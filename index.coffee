express = require 'express'
i18n = require 'i18n-2'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
multer = require 'multer'
path = require 'path'
crypto = require 'crypto'
morgan = require 'morgan'

storage = multer.diskStorage
	destination: (req, file, cb) ->
		publicFields = ['logo']
		if req.query.form in publicFields
			cb(null, './static/uploads/')
		else
			cb(null, './uploads/')
	filename: (req, file, cb) ->
		crypto.pseudoRandomBytes 16, (err, raw) ->
			ext = path.extname file.originalname
			cb null, "#{raw.toString 'hex'}_#{do Date.now}_#{file.originalname.replace /[^\w\d]/g, '_'}"

upload = multer
	storage: storage
	limits:
		fieldNameSize : 100000
		fieldSize : 5242880

# express configuration

app = express()
app.set('views', 'static/views');
app.set 'view engine', 'jade'
app.use express.static __dirname + '/static'

app.use do cookieParser
app.use do bodyParser.json
app.use bodyParser.urlencoded extended: yes, limit: 100000000
app.use morgan 'dev'

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
		res.redirect 'index'

app.route '/request'
	.get (req, res) ->
		res.render 'request', requestForm: _data.requestForm, title: req.i18n.__('request_title')
	.post (req, res) ->
		if db.teams.add req.body
			res.redirect 'index'

app.get '/teams', (req, res) ->
	res.render 'teams', teamsTitle: 'Первый тур', teams: _data.teams, title: req.i18n.__('teams_title')

app.post '/upload', upload.single('file'), (req, res) ->
	res.send req.file


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
