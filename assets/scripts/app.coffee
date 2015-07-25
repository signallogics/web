Cookie = require 'js-cookie'
Cookie.set 'locale', 'ru'

# save request-form to cookie
fields = ['teamName', 'logoLink', 'logoFile', 'city', 'university', 'serviceLink', 'serviceFile', 'videoLink', 'videoFile', 'author']
document.addEventListener 'DOMContentLoaded', ->

	for element in document.querySelectorAll 'a[href*=http]'
		element.setAttribute 'target', '_blank'

	form = document.getElementById 'request-form'
	if form?
		for field in fields
			val = localStorage.getItem "request-form-#{field}"
			if val then form[field].value = val

		form.onsubmit = ->
			do form.reset
			for field in fields
				localStorage.removeItem "request-form-#{field}"

window.onunload = ->
	form = document.getElementById 'request-form'
	if form?
		for field in fields
			localStorage.setItem "request-form-#{field}", form[field].value

