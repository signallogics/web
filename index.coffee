
debug = require('debug') 'ctfight'
app = require './lib/ctfight.coffee'
config = require './config.coffee'

# launch server #
_server = app.listen config.port, ->
	debug "Listening on port #{config.port}"
