crypto = require 'crypto'
multer = require 'multer'
mkdirp = require 'mkdirp'
path = require 'path'
fs = require 'fs'


errors =
	1000:
		code: 1000
		message: 'Unknown error'
	1001:
		code: 1001
		message: 'File is not image'
	1002:
		code: 1002
		message: 'File is too big'


# files are keeping in static/uploads (any user can get it)
# only small files
fields =
	images: ['logo']
fields.public = fields.images

storage = multer.diskStorage
	destination: (req, file, cb) ->
		if req.query.form in fields.public
			cb null, './static/uploads/'
		else
			cb null, './uploads/'
	filename: (req, file, cb) ->
		crypto.pseudoRandomBytes 16, (err, raw) ->
			ext = path.extname file.originalname
			cb null, "#{raw.toString 'hex'}_#{do Date.now}_#{file.originalname.replace /[^\w\d]/g, '_'}"

upload = multer
	storage: storage
	fileFilter: fileFilter
	limits:
		fieldNameSize : 100000
		fieldSize : 1024

fileFilter = (req, file, cb) ->
	if req.query.form in fields.images and file.mimetype.slice(0, 5) isnt 'image'
		req.file =
			error_code: 1001
			error_message: errors[1001].message
		cb null, no
	else
		cb null, yes

handler = (req, res) ->
	unless req.file
		return res.send error: errors[1000]

	unless req.file.error_code
		if (req.query.form in fields.images and req.file.size > 1024 * 1024 * 10 ) \ # image is bigger then 10 Mb
			or req.file.size > 1024 * 1024 * 1024 # file is bigger then 1 Gb
				fs.unlink req.file.path
				return res.send error: errors[1002]

		return res.send file: req.file

	else
		return res.send error: errors[req.file.error_code] or errors[1000]


# create folders for uploads if it doesn't exist
mkdirp 'uploads', (err) ->
	if err then return console.error err
	console.log 'Uploads folder created'

mkdirp 'static/uploads', (err) ->
	if err then return console.error err
	console.log 'Static/uploads folder created'

module.exports =
	upload: upload
	handler: handler
