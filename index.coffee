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
	results:
		defense: 523
		offense: 216
,
	name: 'Команда'
	logo: undefined
	info: 'Новосибирск, НовГУ'
	results:
		defense: 123
		offense: 234
,
	name: 'Команда 2'
	logo: undefined
	info: 'Москва, МГУ'
	results:
		defense: undefined
		offense: undefined
]

requestForm =
	fields: [
		name: 'teamName'
		placeholder: 'Название команды'
		mark: 'Обязательно'
		tip:
			title: 'Название команды'
			text: 'Вы сможете изменить название позже'
	,
		name: 'logoLink'
		placeholder: 'Логотип (ссылка или файл)'
		file:
			text: 'выбрать'
			name: 'logoFile'
		tip:
			title: 'Логотип'
			text: 'Вставьте ссылку или выберите файл с компьютера. Размер файла должен быть не менее 100x100 и не более 1000x1000.'
	,
		name: 'city'
		placeholder: 'Город'
		tip:
			title: 'Город'
			text: 'Укажите город или города, если у вас сборная команда'
	,
		name: 'university'
		placeholder: 'Университет'
		tip:
			title: 'Университет'
			text: 'Укажите университет или университеты, если у вас сборная команда. Вы можете оставить это поле пустым, если не учитесь.'
	,
		name: 'serviceLink'
		placeholder: 'Сервис (ссылка или файл)'
		mark: 'Обязательно'
		file:
			text: 'выбрать'
			name: 'serviceFile'
		tip:
			title: 'Сервис'
			text: 'Вставьте ссылку или выберите файл. Сервис должен содержать не менее двух уязвимостей. Не забудьте добавить deb-package или инструкцию по установке. Железо для запуска сервиса предоставляет команда keva.'
	,
		name: 'videoLink'
		placeholder: 'Видео-разбор (ссылка или файл)'
		mark: 'Обязательно'
		file:
			text: 'выбрать'
			name: 'videoFile'
		tip:
			title: 'Видео-разбор'
			text: 'Разбор уязвимостей. Постарайтесь уложиться в 20 минут.'
	,
		name: 'author'
		placeholder: 'Автор или авторы сервиса'
		tip:
			title: 'Автор или авторы сервиса'
			text: 'Добавьте автора, авторов и/или команду, разработавшую сервис. По умолчанию это ваша команда.'
	]
	submit:
		text: 'отправить заявку'


# main pages #

app.get ['/', '/index'], (req, res) ->
	res.render 'index'

app.route '/request'
	.get (req, res) ->
		res.render 'request', requestForm: requestForm
	.post (req, res) ->
		res.redirect 'index'

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
