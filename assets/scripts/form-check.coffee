module.exports = (id, inputs, callback) ->
	form = document.getElementById(id)
	if form
		form.onsubmit = (e) ->
			for inputName of inputs
				input = form[inputName]
				regex = inputs[inputName]
				check = (value) -> not regex.test value
				switch typeof regex
					when 'string'
						regex = switch
							when regex is 'email' then /.+@.+\..+/i
							when regex is 'nonempty' then /.+/
							else /.*/
					when 'function'
						check = regex
					else /.*/

				if check input.value
					time = .7
					richInput = input.parentElement
					richInput.classList.add 'input--wrong'
					richInput.classList.add 'input--shake'
					input.onfocus = (-> @classList.remove 'input--wrong').bind richInput
					setTimeout (-> @classList.remove 'input--shake').bind(richInput), 1000
					errorInForm = yes
			if errorInForm
				return no
			return callback e, form

