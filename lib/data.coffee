requestForm =
	fields: [
		name: 'teamName'
		type: 'text'
		placeholder: 'team_name'
		mark: 'necessary'
		tip:
			title: 'team_name'
			text: 'tip_team_name'
	,
		name: 'email'
		type: 'email'
		placeholder: 'email'
		mark: 'necessary'
		tip:
			title: 'contact_email'
			text: 'tip_email'
	,
		name: 'contacts'
		type: 'text'
		placeholder: 'contacts'
		tip:
			title: 'contact_details'
			text: 'tip_contacts'
	,
		name: 'logoLink'
		type: 'text'
		placeholder: 'logo_link_or_file'
		file:
			static: yes
			text: 'choose'
			name: 'logo'
		tip:
			title: 'logo'
			text: 'tip_logo'
	,
		name: 'info'
		type: 'text'
		placeholder: 'info'
		tip:
			title: 'info'
			text: 'tip_info'
	,
		name: 'serviceLink'
		type: 'text'
		placeholder: 'service_link_or_file'
		mark: 'necessary'
		file:
			static: no
			text: 'choose'
			name: 'service'
		tip:
			title: 'service'
			text: 'tip_service'
	,
		name: 'videoLink'
		type: 'text'
		placeholder: 'video_write_up_link_or_file'
		mark: 'necessary'
		file:
			static: no
			text: 'choose'
			name: 'video'
		tip:
			title: 'video_write_up'
			text: 'tip_video_write_up'
	,
		name: 'author'
		type: 'text'
		placeholder: 'author_or_authors'
		tip:
			title: 'author_or_authors'
			text: 'tip_author_or_authors'
	]
	submit:
		text: 'send_request'

module.exports =
	requestForm: requestForm
