module.exports = (id, inputs) ->
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
					input.style.transitionDuration = "#{time}s"
					input.classList.add 'input--wrong'
					setTimeout (-> this.classList.remove 'input--wrong').bind(input), time * 1000
					errorInForm = yes
			if errorInForm
				return no

