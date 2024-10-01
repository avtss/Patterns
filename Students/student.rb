class Student
	attr_reader :id, :lastname, :firstname, :surname
	attr_accessor :phone, :telegram, :email, :github

	def initialize(id:, lastname:, firstname:, surname:, phone:nil, telegram:nil, email:nil, github:nil)
		@id=id
		@lastname=lastname
		@firstname=firstname
		@surname=surname
		@phone=phone
		@telegram=telegram
		@email=email
		@github=github
	end
	def to_s
		"ID: #{@id}, ФИО: #{@lastname} #{@firstname} #{surname}, номер телефона: #{@phone}, tg: #{@telegram}, email: #{@email}, github: #{@github}"
	end
	def display_info
    	puts "Информация о студенте:"
    	puts "ID: #{@id}"
    	puts "ФИО: #{@lastname} #{@firstname} #{@surname}"
    	puts "Телефон: #{@phone}"
    	puts "Telegram: #{@telegram}"
    	puts "Email: #{@email}"
    	puts "GitHub: #{@github}"
  	end
end