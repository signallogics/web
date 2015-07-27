mongoose = require 'mongoose'

port = 27017
mongoose.connect "mongodb://localhost:#{port}/ctfight"
db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'

teamSchema = mongoose.Schema
	name: String
	email: String
	logo:
		pathType: String
		path: String
	city: String
	university: String
	service:
		pathType: String
		path: String
	video:
		pathType: String
		path: String
	author: String

Team = mongoose.model 'Team', teamSchema



module.exports =

	###*
	#	Adding team with one email field to database
	#	@param [string] email
	###
	addEmail: (email) ->
		team = new Team email: email
		Team.update email: email, team, upsert: true, (err, team) ->
			if err then return console.error err


	###*
	#	Adding team with all fields
	#	@param [object] data
	# 	@require [string] teamName
	# 	@require [string] email
	# 	@require [string] service or serviceLink
	# 	@require [string] video or videoLink
	# 	@option  [string] city
	# 	@option  [string] university
	# 	@option  [string] author
	# 	@option  [string] logo
	# 	@option  [string] logoLink
	###
	addTeam: (data) ->
		unless data.teamName \
			and  data.email \
			and (data.service or data.serviceLink) \
			and (data.video or data.videoLink)
				return no
		team = {}
		team.teamName = data.teamName
		team.email = data.email if data.email
		team.city = data.city if data.city
		team.university = data.university if data.university
		team.author = data.author if data.author

		choiceType = (file, link) ->
			if file
				pathType: 'file'
				path: file
			else if link
				pathType: 'url'
				path: link
			else
				# TODO: Write error to logs
				{}

		team.logo = choiceType data.logo, data.logoLink
		team.service = choiceType data.service, data.serviceLink
		team.video = choiceType data.video, data.videoLink

		Team.update email: team.email, team, upsert: true, (err, team) ->
			if err then return console.error err

		return yes
