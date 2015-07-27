mongoose = require 'mongoose'

port = 27017
mongoose.connect "mongodb://localhost:#{port}/ctfight"
db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'
db.once 'open', (callback) ->
	console.log 'open'

teamSchema = mongoose.Schema
	name: String
	email: String
	logo: String
	city: String
	university: String
	service: String
	video: String
	author: String

Team = mongoose.model 'Team', teamSchema

module.exports =

	###*
	#	Adding team with one email field to database
	#	@param [string] email
	#	@return [bool] success
	###
	addEmail: (email) ->
		team = new Team email: email
		Team.update email: email, team, upsert: true, (err, team) ->
			if err then return console.error err
			return yes
