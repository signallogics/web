request = require 'supertest'

app = require '../lib/ctfight.coffee'

describe 'GET pages access', ->

	it '/ respond', (done) ->
		request app
			.get '/'
			.expect 200, done

	it '/index respond', (done) ->
		request app
			.get '/index'
			.expect 200, done

	it '/teams respond', (done) ->
		request app
			.get '/teams'
			.expect 200, done

	it '/request respond', (done) ->
		request app
			.get '/request'
			.expect 200, done

	it '/translation respond', (done) ->
		request app
			.get '/translation'
			.expect 200, done

# TODO: Upload file and check md5 sum
