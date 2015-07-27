Cookie = require 'js-cookie'

upload = require './upload.coffee'

# Cookie.set 'locale', 'ru'

formCheck = require './form-check.coffee'

# save request-form to cookie
fields = ['teamName', 'email', 'info', 'author']
document.addEventListener 'DOMContentLoaded', ->

	for element in document.querySelectorAll 'a[href*=http]'
		element.setAttribute 'target', '_blank'

	form = document.getElementById 'request-form'
	if form
		for field in fields
			val = localStorage.getItem "request-form-#{field}"
			if val then form[field].value = val

		form.onsubmit = (e) ->
			do e.preventDefault
			do this.submit
			do form.reset
			for field in fields
				localStorage.removeItem "request-form-#{field}"

		for element in document.querySelectorAll('.input--file__input')
			element.onchange = (e) ->
				upload e.srcElement, this.form

	formCheck 'remind-form', email: 'email'
	formCheck 'request-form',
		teamName: 'nonempty'
		email: 'email'
		serviceLink: 'nonempty'
		videoLink: 'nonempty'

window.onunload = ->
	form = document.getElementById 'request-form'
	if form
		localStorage.setItem 'email', form.email.value
		for field in fields
			localStorage.setItem "request-form-#{field}", form[field].value

	form = document.getElementById 'remind-form'
	if form and form.email.value
		localStorage.setItem 'request-form-email', form.email.value

