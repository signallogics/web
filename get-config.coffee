if process.env.NODE_ENV is 'test'
	config = 
		NODE_ENV: 'test'
		PORT: 5000
		ADMIN_PASS: 'pass'
		MONGO_PORT: 27017
		MONGO_HOST: 'localhost'

else
	config = require './config.coffee'

module.exports = config
