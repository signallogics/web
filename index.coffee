
debug = require('debug') 'ctfight'
app = require './lib/ctfight.coffee'

# launch server #
port = process.env.PORT or 5000
_server = app.listen port, ->
	debug "Listening on port #{port}"
