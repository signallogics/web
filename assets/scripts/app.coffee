Cookie = require 'js-cookie'

# save request-form to cookie

fields = ['teamName', 'logoLink', 'logoFile', 'city', 'university', 'serviceLink', 'serviceFile', 'videoLink', 'videoFile', 'author']
document.addEventListener 'DOMContentLoaded', ->
	form = document.getElementById 'request-form'
	if form?
		for field in fields
			form[field].value = Cookie.get "request-form-#{field}"

window.onunload = ->
	form = document.getElementById 'request-form'
	if form?
		for field in fields
			Cookie.set "request-form-#{field}", form[field].value
