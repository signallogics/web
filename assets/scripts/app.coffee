Cookie = require 'js-cookie'
# Cookie.set 'locale', 'ru'

# save request-form to cookie
fields = ['teamName', 'logoLink', 'logoFile', 'city', 'university', 'serviceLink', 'serviceFile', 'videoLink', 'videoFile', 'author', 'email']
document.addEventListener 'DOMContentLoaded', ->

	for element in document.querySelectorAll 'a[href*=http]'
		element.setAttribute 'target', '_blank'

	form = document.getElementById 'request-form'
	if form
		for field in fields
			val = localStorage.getItem "request-form-#{field}"
			if val then form[field].value = val

		form.onsubmit = ->
			do form.reset
			for field in fields
				localStorage.removeItem "request-form-#{field}"

	form = document.getElementById('remind-form')
	if form
		form.onsubmit = (e) ->
			regex = /.+@.+\..+/i
			input = form.email
			unless regex.test input.value
				time = .7
				input.style.transitionDuration = "#{time}s"
				input.classList.add 'input--wrong'
				setTimeout (-> input.classList.remove 'input--wrong'), time * 1000
				no

window.onunload = ->
	form = document.getElementById 'request-form'
	if form
		localStorage.setItem 'email', form.email.value
		for field in fields
			localStorage.setItem "request-form-#{field}", form[field].value

	form = document.getElementById 'remind-form'
	if form and form.email.value
		localStorage.setItem 'request-form-email', form.email.value

