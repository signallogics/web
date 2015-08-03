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

