
debug = require('debug') 'ctfight'
app = require './lib/ctfight.coffee'
config = require './get-config.coffee'

# launch server #
_server = app.listen config.PORT, ->
	console.log "Listening on port #{config.PORT}"
