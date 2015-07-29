Cookie = require 'js-cookie'

upload = require './upload.coffee'

# Cookie.set 'locale', 'ru'

formCheck = require './form-check.coffee'

# save request-form to cookie
fields = ['teamName', 'email', 'contacts', 'info', 'author']
document.addEventListener 'DOMContentLoaded', ->

	for element in document.querySelectorAll 'a[href*=http]'
		element.setAttribute 'target', '_blank'

	form = document.getElementById 'request-form'
	if form
		for field in fields
			val = localStorage.getItem "request-form-#{field}"
			if val then form[field].value = val

		for element in document.querySelectorAll('.input--file__input')
			element.onchange = ->
				upload this, this.form

	formCheck 'remind-form', email: 'email'
	formCheck 'request-form',
		teamName: 'nonempty'
		email: 'email'
		serviceLink: 'nonempty'
		videoLink: 'nonempty', (e, form) ->
			do form.submit
			form.resetOnUnload = yes
			return yes


window.onunload = ->
	form = document.getElementById 'request-form'
	if form
		if form.resetOnUnload
			for field in fields
				localStorage.removeItem "request-form-#{field}"
		else
			localStorage.setItem 'email', form.email.value
			for field in fields
				localStorage.setItem "request-form-#{field}", form[field].value

	form = document.getElementById 'remind-form'
	if form and form.email.value
		localStorage.setItem 'request-form-email', form.email.value

