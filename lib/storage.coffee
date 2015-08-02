crypto = require 'crypto'
multer = require 'multer'
mkdirp = require 'mkdirp'
path = require 'path'
fs = require 'fs'


errors =
	UNKNOWN:
		code: 'UNKNOWN'
		message: 'Unknown error'
	NOT_IMAGE:
		code: 'NOT_IMAGE'
		message: 'File is not an image'
	FILE_LARGE:
		code: 'FILE_LARGE'
		message: 'File is too big'

# create folders for uploads if it doesn't exist
mkdirp 'uploads', (err) ->
	if err then return console.error err
	console.log 'Uploads folder created'

mkdirp 'static/uploads', (err) ->
	if err then return console.error err
	console.log 'Static/uploads folder created'


# files are keeping in static/uploads (any user can get it)
# only small files
fields =
	images: ['logo']
fields.public = fields.images


fileIsImageFilter = (req, file, cb) ->
	if file.mimetype.slice(0, 5) isnt 'image'
		req.file =
			error_code: 'NOT_IMAGE'
			error_message: errors.NOT_IMAGE.message
		cb null, no
	else
		cb null, yes


handler = (req, res) ->

	unless req.file
		return res.send error: errors.UNKNOWN

	unless req.file.error_code
		# delete after fix this bug (https://github.com/expressjs/multer/issues/168)
		if req.file.size > 1024 * 1024 * 5 and req.file.mimetype.slice(0, 5) is 'image' #
			fs.unlink req.file.path                                        #
			return res.send                                                #
				error: errors.FILE_LARGE                                     #
		return res.send file: req.file

	else
		return res.send error: errors[req.file.error_code] or errors.UNKNOWN

limitHandler = (err, req, res, next) ->
	if err.code is 'LIMIT_FILE_SIZE'
		res.send
			result: 'fail'
			error: errors.FILE_LARGE

uploadFileName = (req, file, cb) ->
	crypto.pseudoRandomBytes 16, (err, raw) ->
		ext = path.extname file.originalname
		cb null, "#{raw.toString 'hex'}_#{do Date.now}_#{file.originalname.replace /[^\w\d]/g, '_'}"

upload = multer
	storage: multer.diskStorage
		destination: './uploads/'
		filename: uploadFileName
	limits:
		fileSize: 1024 * 1024 * 1024

uploadImages = multer
	storage: multer.diskStorage
		destination: './static/uploads/'
		filename: uploadFileName
	fileFilter: fileIsImageFilter
	limits:
		fileSize: 1024 * 1024 * 5
		# delete after fix this bug (https://github.com/expressjs/multer/issues/168)
		fileSize: 1024 * 1024 * 1024       #



module.exports =
	upload: upload
	uploadImages: uploadImages
	handler: handler
	limitHandler: limitHandler
