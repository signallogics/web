superagent = require 'supertest'

app = require '../lib/ctfight.coffee'

describe 'GET pages access', ->

	it '/', (done) ->
		superagent app
			.get '/'
			.expect 200, done

	it '/index', (done) ->
		superagent app
			.get '/index'
			.expect 200, done

	it '/teams', (done) ->
		superagent app
			.get '/teams'
			.expect 200, done

	it '/request', (done) ->
		superagent app
			.get '/request'
			.expect 200, done

	it '/translation', (done) ->
		superagent app
			.get '/translation'
			.expect 200, done


# TODO: Upload file and check md5 sum
