crypto = require 'crypto'
multer = require 'multer'
mkdirp = require 'mkdirp'
path = require 'path'

# keep files in static/uploads (any user can get it)
# only small files
imagesFields = ['logo']
publicFields = imagesFields

storage = multer.diskStorage
	destination: (req, file, cb) ->
		if req.query.form in publicFields
			cb null, './static/uploads/'
		else
			cb null, './uploads/'
	filename: (req, file, cb) ->
		crypto.pseudoRandomBytes 16, (err, raw) ->
			ext = path.extname file.originalname
			cb null, "#{raw.toString 'hex'}_#{do Date.now}_#{file.originalname.replace /[^\w\d]/g, '_'}"

upload = multer
	storage: storage
	limits:
		fieldNameSize : 100000
		fieldSize : 5242880

# create folders for uploads if it doesn't exist
mkdirp 'uploads', (err) ->
	if err then return console.error err
	console.log 'Uploads folder created'

mkdirp 'static/uploads', (err) ->
	if err then return console.error err
	console.log 'Static/uploads folder created'

module.exports = upload
