debug = require('debug') 'ctfight:db'
mongoose = require 'mongoose'

# process.env.MONGO_PORT_27017_TCP_ADDR is wrong, if don't know why
if process.env.MONGO_PORT_27017_TCP_PORT
	host = 'mongo'
	port = process.env.MONGO_PORT_27017_TCP_PORT
else
	host = 'localhost'
	port = 27017

mongoose.connect "mongodb://#{host}:#{port}/ctfight"
db = mongoose.connection
db.on 'error', console.error.bind console, 'Connection error:'
db.once 'open', -> debug 'Connection open successful'

teamSchema = mongoose.Schema
	name: String
	email: String
	logo:
		pathType: String
		path: String
	info: String
	service:
		pathType: String
		path: String
	video:
		pathType: String
		path: String
	author: String
	results:
		defense: Number
		offense: Number
	verified:
		type: Boolean
		default: no
	registrationDate:
		type: Date
		default: Date.now
	tour:
		type: Number
		default: 1


Team = mongoose.model 'Team', teamSchema



module.exports =


	teams:

		###*
		#	Adding team with one email field to database
		#	@param [string] email
		###
		addOnlyEmail: (email) ->
			team = new Team email: email
			Team.update email: email, team, upsert: true, (err, team) ->
				# TODO: Write error to logs
				if err then return console.error err


		###*
		#	Adding team with all fields
		#	@param [object] data
		# 	@require [string] teamName
		# 	@require [string] email
		# 	@require [string] service or serviceLink
		# 	@require [string] video or videoLink
		# 	@option  [string] info
		# 	@option  [string] author
		# 	@option  [string] logo
		# 	@option  [string] logoLink
		###
		add: (data, callback) ->
			unless data.teamName \
				and  data.email \
				and (data.service or data.serviceLink) \
				and (data.video or data.videoLink)
					callback
						code: 'NO_MANDATORY_FIELDS'
						message: 'Required teamName, email, service (path or link) and video (path or link)'
			team = new Team()
			team.name = data.teamName
			team.email = data.email if data.email
			team.info = data.info if data.info
			team.author = data.author if data.author

			choiceType = (file, link) ->
				if file
					pathType: 'file'
					path: file
				else if link
					pathType: 'url'
					path: link
				else
					{}

			team.logo = choiceType(data.logo, data.logoLink)
			team.service = choiceType(data.service, data.serviceLink)
			team.video = choiceType(data.video, data.videoLink)

			###*
			# Update team if it doesn't have name
			# Return error WRONG_EMAIL if email is already in use by any team
			# Insert new team otherwise
			###
			Team.find { tour: 1, email: team.email }, (err, response) ->

				if err then return callback err
				if response[0] and response[0].name
					err =
						code: 'WRONG_EMAIL'
						message: 'This email is already in use'
					return callback err

				Team.update { tour: 1, email: team.email, name: $exists: no }, team, upsert: true, (err, team) ->
					return callback err


		###*
		#	Getting all teams
		#	@return [array] teams
		###
		list: (callback) ->
			Team.find name: $exists: yes, (err, teams) ->
				if err
					# TODO: Write error to logs
					console.error err

				callback err, teams

