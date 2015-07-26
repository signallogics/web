teams = [
	name: 'keva'
	logo: 'http://keva.su/uploads/2013/11/keva.png'
	info: 'Томск, ТУСУР'
	results:
		defense: 523
		offense: 216
,
	name: 'Команда'
	logo: undefined
	info: 'Новосибирск, НовГУ'
	results:
		defense: 123
		offense: 234
,
	name: 'Команда 2'
	logo: undefined
	info: 'Москва, МГУ'
	results:
		defense: undefined
		offense: undefined
]

requestForm =
	fields: [
		name: 'teamName'
		placeholder: 'team_name'
		mark: 'necessary'
		tip:
			title: 'team_name'
			text: 'tip_team_name'
	,
		name: 'email'
		placeholder: 'email'
		mark: 'necessary'
		tip:
			title: 'contact_email'
			text: 'tip_email'
	,
		name: 'logoLink'
		placeholder: 'logo_link_or_file'
		file:
			text: 'choose'
			name: 'logoFile'
		tip:
			title: 'logo'
			text: 'tip_logo'
	,
		name: 'city'
		placeholder: 'city'
		tip:
			title: 'city'
			text: 'tip_city'
	,
		name: 'university'
		placeholder: 'university'
		tip:
			title: 'university'
			text: 'tip_university'
	,
		name: 'serviceLink'
		placeholder: 'service_link_or_file'
		mark: 'necessary'
		file:
			text: 'choose'
			name: 'serviceFile'
		tip:
			title: 'service'
			text: 'tip_service'
	,
		name: 'videoLink'
		placeholder: 'video_write_up_link_or_file'
		mark: 'necessary'
		file:
			text: 'choose'
			name: 'videoFile'
		tip:
			title: 'video_write_up'
			text: 'tip_video_write_up'
	,
		name: 'author'
		placeholder: 'author_or_authors'
		tip:
			title: 'author_or_authors'
			text: 'tip_author_or_authors'
	]
	submit:
		text: 'send_request'

module.exports =
	teams: teams
	requestForm: requestForm
