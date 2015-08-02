srg = require '../lib/storage.coffee'

chai = require 'chai'
assert = chai.assert

describe 'storage', ->
	describe 'fileIsImageFilter()', ->

		it 'should send error NOT_IMAGE if file mimetype is not image', ->
			req = file: undefined
			file = mimetype: 'not/image'
			cb = (err, pass) ->
				assert(not pass)
			srg._fileIsImageFilter req, file, cb

		it 'should pass file if mimetype start with "image"', ->
			req = file: undefined
			file = mimetype: 'image/image'
			cb = (err, pass) ->
				assert(pass)
			srg._fileIsImageFilter req, file, cb
