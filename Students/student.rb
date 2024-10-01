class Student
	attr_reader :id, :lastname, :firstname, :surname
	attr_accessor :phone, :telegram, :email, :github

	PHONE_REGEX = /^\+7\d{10}$/

	def self.valid_phone?(phone)
    	phone =~ PHONE_REGEX
 	end


 	def phone=(number)
    	raise ArgumentError, "Некорректный номер телефона" unless self.class.valid_phone?(number)
    	@phone = number
  	end
  	
	def initialize(id:, lastname:, firstname:, surname:, phone:nil, telegram:nil, email:nil, github:nil)
		@id=id
		@lastname=lastname
		@firstname=firstname
		@surname=surname
		self.phone = phone
		@telegram=telegram
		@email=email
		@github=github
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