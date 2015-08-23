
debug = require('debug') 'ctfight'
app = require './lib/ctfight.coffee'
app.get '*', (req, res) ->
	res.redirect '/'

# launch server #
_server = app.listen 5000, ->
	debug 'Listening on port 5000'
