crypto = require 'crypto'
multer = require 'multer'
mkdirp = require 'mkdirp'
path = require 'path'
fs = require 'fs'
debug = require('debug') 'ctfight:storage'


m = {}
module.exports = m

m._errors =
		UNKNOWN:
			code: 'UNKNOWN'
			message: 'Unknown error'
		NOT_IMAGE:
			code: 'NOT_IMAGE'
			message: 'File is not an image'
		FILE_LARGE:
			code: 'FILE_LARGE'
			message: 'File is too big'


m._fileIsImageFilter = (req, file, cb) ->
		if file.mimetype.slice(0, 5) isnt 'image'
			req.file =
				error_code: 'NOT_IMAGE'
				error_message: m._errors.NOT_IMAGE.message
			cb null, no
		else
			cb null, yes


m.handler = (req, res) ->

		unless req.file
			return res.send
				result: 'fail'
				error: m._errors.UNKNOWN

		unless req.file.error_code
			return res.send
				result: 'ok'
				file: req.file

		else
			return res.send
				result: 'fail'
				error: m._errors[req.file.error_code] or m._errors.UNKNOWN

# don't work because it's bug of multer module (https://github.com/expressjs/multer/issues/194)
m.limitHandler = (err, req, res, next) ->
		if err.code is 'LIMIT_FILE_SIZE'
			res.send
				result: 'fail'
				error: m._errors.FILE_LARGE
		do next

m.uploadFileName = (req, file, cb) ->
		crypto.pseudoRandomBytes 16, (err, raw) ->
			ext = path.extname file.originalname
			cb null, "#{raw.toString 'hex'}_#{do Date.now}_#{file.originalname.replace /[^\w\d]/g, '_'}"

m.upload = multer
		storage: multer.diskStorage
			destination: './uploads/'
			filename: m.uploadFileName
		limits:
			fileSize: 1024 * 1024 * 1024

m.uploadImages = multer
		storage: multer.diskStorage
			destination: './static/uploads/'
			filename: m.uploadFileName
		fileFilter: m._fileIsImageFilter
		limits:
			fileSize: 1024 * 1024 * 5
