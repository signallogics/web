
debug = require('debug') 'ctfight'
app = require './lib/ctfight.coffee'

# launch server #
_server = app.listen 5000, ->
	debug 'Listening on port 5000'
