superagent = require 'supertest'

app = require '../lib/ctfight.coffee'

describe 'GET pages access', ->

	it '/ respond', (done) ->
		superagent app
			.get '/'
			.expect 200, done

	it '/index respond', (done) ->
		superagent app
			.get '/index'
			.expect 200, done

	it '/teams respond', (done) ->
		superagent app
			.get '/teams'
			.expect 200, done

	it '/request respond', (done) ->
		superagent app
			.get '/request'
			.expect 200, done

	it '/translation respond', (done) ->
		superagent app
			.get '/translation'
			.expect 200, done


# TODO: Upload file and check md5 sum
