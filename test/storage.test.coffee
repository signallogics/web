srg = require '../lib/storage.coffee'
fs = require 'fs'

chai = require 'chai'
assert = chai.assert

describe 'storage', ->

	describe '_fileIsImageFilter()', ->

		it 'should send error NOT_IMAGE if file mimetype is not image', ->
			req = file: undefined
			file = mimetype: 'not/image'
			cb = (err, pass) ->
				assert not pass
			srg._fileIsImageFilter req, file, cb

		it 'should pass file if mimetype start with "image"', ->
			req = file: undefined
			file = mimetype: 'image/image'
			cb = (err, pass) ->
				assert pass
			srg._fileIsImageFilter req, file, cb

	describe 'Exists uploads folders', ->

		it 'should exists uploads folder', (done) ->
			fs.exists 'uploads', (exists) ->
				if exists
					do done
				else
					done new Error 'Not found /uploads'

		it 'should exists static/uploads folder', (done) ->
			fs.exists 'static/uploads', (exists) ->
				if exists
					do done
				else
					done new Error 'Not found /static/uploads'

	describe 'uploads handler', ->

		it 'should return UNKNOWN error if req.file not exists', ->
			req = {}
			res =
				send: (data) ->
					assert.equal data.result, 'fail'
					assert.equal data.error.code, 'UNKNOWN'
			srg.handler req, res

		it 'should return FILE_LARGE error if req.file.size is bigger then 5 Mb and file is image', ->
			fs.closeSync fs.openSync '/tmp/ctfight_test_file', 'w'
			req =
				file:
					mimetype: 'image/jpg'
					size: 1024 * 1024 * 1024
					path: '/tmp/ctfight_test_file'
			res =
				send: (data) ->
					assert.equal data.result, 'fail'
					assert.equal data.error.code, 'FILE_LARGE'
			srg.handler req, res

		it 'should return file if image is less then 5 Mb', ->
			req =
				file:
					mimetype: 'image/jpg'
					size: 1024 * 1024 * 3
			res =
				send: (data) ->
					assert.equal data.result, 'ok'
					assert.equal data.file, req.file
			srg.handler req, res

	describe 'limit file size handler', ->
		it 'should return FILE_LARGE error', ->
			err = code: 'LIMIT_FILE_SIZE'
			req = {}
			res = send: (data) ->
				assert.equal data.result, 'fail'
				assert.equal data.error.code, 'FILE_LARGE'
			next = ->
			srg.limitHandler err, req, res, next









