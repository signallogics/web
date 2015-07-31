humane = require 'humane-js'
module.exports = (element, form, staticFile) ->
	url = '/upload'
	url += '/static' if staticFile
	xhr = new XMLHttpRequest()
	fd = new FormData(form)

	textField = element.parentElement.parentElement.querySelector 'input'
	progressBar = element.parentElement.parentElement.querySelector '.input--file__view__progress'
	hiddenField = element.parentElement.querySelector '[type="hidden"]'

	xhr.open 'post', url, true

	xhr.onreadystatechange = ->
		if xhr.readyState is 4 and xhr.status is 200
			data = JSON.parse xhr.responseText
			unless data.error
				textField.value = data.file.originalname
				textField.disabled = yes
				hiddenField.value = data.file.path
			else
				request = new XMLHttpRequest()
				request.open 'GET', "/translation?text=error_#{data.error.code}", true
				request.onreadystatechange = ->
					if request.readyState is 4 and request.status is 200
						data = JSON.parse request.responseText
						humane.log data.text
						progressBar.setAttribute 'data-percent', 0
				do request.send


	xhr.upload.onprogress = (e) ->
		progress = (e.position or e.loaded) / (e.totalSize or e.total)
		progressBar.setAttribute 'data-percent', Math.floor progress * 100

	xhr.send fd
