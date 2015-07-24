Cookie = require 'js-cookie'

# save request-form to cookie

fields = ['teamName', 'logoLink', 'logoFile', 'city', 'university', 'serviceLink', 'serviceFile', 'videoLink', 'videoFile', 'author']
document.addEventListener 'DOMContentLoaded', ->
	form = document.getElementById 'request-form'
	if form?
		for field in fields
			val = Cookie.get "request-form-#{field}"
			if val then form[field].value = val

		form.onsubmit = ->
			for field in fields
				Cookie.remove "request-form-#{field}"


window.onunload = ->
	form = document.getElementById 'request-form'
	if form?
		for field in fields
			Cookie.set "request-form-#{field}", form[field].value, expires: 365

