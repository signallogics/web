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
		placeholder: 'Название команды'
		mark: 'Обязательно'
		tip:
			title: 'Название команды'
			text: 'Вы сможете изменить название позже'
	,
		name: 'logoLink'
		placeholder: 'Логотип (ссылка или файл)'
		file:
			text: 'выбрать'
			name: 'logoFile'
		tip:
			title: 'Логотип'
			text: 'Вставьте ссылку или выберите файл с компьютера. Размер файла должен быть не менее 100x100 и не более 1000x1000.'
	,
		name: 'city'
		placeholder: 'Город'
		tip:
			title: 'Город'
			text: 'Укажите город или города, если у вас сборная команда'
	,
		name: 'university'
		placeholder: 'Университет'
		tip:
			title: 'Университет'
			text: 'Укажите университет или университеты, если у вас сборная команда. Вы можете оставить это поле пустым, если не учитесь.'
	,
		name: 'serviceLink'
		placeholder: 'Сервис (ссылка или файл)'
		mark: 'Обязательно'
		file:
			text: 'выбрать'
			name: 'serviceFile'
		tip:
			title: 'Сервис'
			text: 'Вставьте ссылку или выберите файл. Сервис должен содержать не менее двух уязвимостей. Не забудьте добавить deb-package или инструкцию по установке. Железо для запуска сервиса предоставляет команда keva.'
	,
		name: 'videoLink'
		placeholder: 'Видео-разбор (ссылка или файл)'
		mark: 'Обязательно'
		file:
			text: 'выбрать'
			name: 'videoFile'
		tip:
			title: 'Видео-разбор'
			text: 'Разбор уязвимостей. Постарайтесь уложиться в 20 минут.'
	,
		name: 'author'
		placeholder: 'Автор или авторы сервиса'
		tip:
			title: 'Автор или авторы сервиса'
			text: 'Добавьте автора, авторов и/или команду, разработавшую сервис. По умолчанию это ваша команда.'
	]
	submit:
		text: 'отправить заявку'

module.exports =
	teams: teams
	requestForm: requestForm
