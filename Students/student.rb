class Student
	attr_reader :id, :lastname, :firstname, :surname
	attr_accessor :phone, :telegram, :email, :github

	PHONE_REGEX = /^\+7\d{10}$/
	NAME_REGEX = /^[А-ЯЁ][а-яё]+\s*$/  
  	EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  	GITHUB_REGEX = /^https?:\/\/github\.com\/[a-zA-Z0-9_-]+$/
  	TELEGRAM_REGEX = /^@\w{5,}$/

	def self.valid_phone?(phone)
    	phone =~ PHONE_REGEX
 	end

 	def self.valid_name?(name)
    	name =~ NAME_REGEX
  	end

  	def self.valid_email?(email)
    	email =~ EMAIL_REGEX
  	end

  	def self.valid_github?(github)
    	github =~ GITHUB_REGEX
  	end

  	def self.valid_telegram?(telegram)
    	telegram =~ TELEGRAM_REGEX
  	end


 	def phone=(number)
    	raise ArgumentError, "Некорректный номер телефона" unless self.class.valid_phone?(number)
    	@phone = number
  	end
  	def lastname=(name)
    	raise ArgumentError, "Некорректная фамилия" unless self.class.valid_name?(name)
    	@lastname = name
  	end

  	def firstname=(name)
    	raise ArgumentError, "Некорректное имя" unless self.class.valid_name?(name)
    	@firstname = name
  	end

  	def surname=(name)
    	raise ArgumentError, "Некорректное отчество" unless self.class.valid_name?(name)
    	@surname = name
  	end

  	def email=(email)
    	raise ArgumentError, "Некорректный email" unless self.class.valid_email?(email)
    	@email = email
  	end

  	def github=(git)
    	raise ArgumentError, "Некорректный GitHub" unless self.class.valid_github?(git)
    	@github = git
  	end

  	def telegram=(username)
    	raise ArgumentError, "Некорректный Telegram" unless self.class.valid_telegram?(username)
    	@telegram = username
  	end

  	def no_contact?
    	@phone.nil? && @telegram.nil? && @email.nil?
  	end

  	def validate
    	raise ArgumentError, "Необходимо указать GitHub" if @github.nil?
    	raise ArgumentError, "Необходимо указать хотя бы один контакт для связи" if no_contact?
  	end

	def initialize(id:, lastname:, firstname:, surname:, phone: nil, telegram: nil, email: nil, github: nil)
    	@id = id
    	self.lastname = lastname
    	self.firstname = firstname
    	self.surname = surname
    	self.phone = phone
    	self.telegram = telegram
    	self.email = email
    	self.github = github
  	end
	

	def display_info
    	puts "Информация о студенте:"
    	puts "ID: #{@id}"
    	puts "ФИО: #{@lastname} #{@firstname} #{@surname}"
    	puts "Телефон: #{@phone}" if @phone
    	puts "Telegram: #{@telegram}" if @telegram
    	puts "Email: #{@email}" if @email
    	puts "GitHub: #{@github}" if @github
  end
end