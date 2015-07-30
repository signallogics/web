module.exports = (element, form) ->
	url = "/upload?form=#{form.id}"
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
				# TODO: Error message
				console.log 'TODO'

	xhr.upload.onprogress = (e) ->
		progress = (e.position or e.loaded) / (e.totalSize or e.total)
		progressBar.setAttribute 'data-percent', Math.floor progress * 100

	xhr.send fd
