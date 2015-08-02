
debug = require('debug') 'ctfight'
app = require './lib/ctfight.coffee'

process.env.NODE_ENV ||= 'development'

# launch server #
_server = app.listen 5000, ->
	debug 'Listening on port 5000'
