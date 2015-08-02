
app = require './lib/ctfight.coffee'

# launch server #
_server = app.listen 5000, ->
	console.log 'Listening on port 5000'
