
debug = require('debug') 'ctfight'
app = require './lib/ctfight.coffee'
config = require './config.coffee'

# launch server #
console.log 'hello'
_server = app.listen config.PORT, ->
	console.log "Listening on port #{config.PORT}"
