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
		name: 'contacts'
		placeholder: 'contacts'
		tip:
			title: 'contact_details'
			text: 'tip_contacts'
	,
		name: 'logoLink'
		placeholder: 'logo_link_or_file'
		file:
			text: 'choose'
			name: 'logo'
		tip:
			title: 'logo'
			text: 'tip_logo'
	,
		name: 'info'
		placeholder: 'info'
		tip:
			title: 'info'
			text: 'tip_info'
	,
		name: 'serviceLink'
		placeholder: 'service_link_or_file'
		mark: 'necessary'
		file:
			text: 'choose'
			name: 'service'
		tip:
			title: 'service'
			text: 'tip_service'
	,
		name: 'videoLink'
		placeholder: 'video_write_up_link_or_file'
		mark: 'necessary'
		file:
			text: 'choose'
			name: 'video'
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
