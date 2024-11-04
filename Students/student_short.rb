require_relative 'human'
require_relative 'student'

class Student_short < Human
  attr_reader :lastname_initials, :contact
  def initialize(student)
    @id=student.id 
    @github=student.github
    @lastname_initials = student.fullname
    @contact = student.contact_info
  end

 #Фамилия;Имя;Отчество;Git;Телефон;Тг;Email  
  def self.from_string(id, input)
    info = input.split(';')
    raise ArgumentError, "Неверное количество параметров" unless info.size >= 5

    lastname = info[0].strip
    firstname = info[1].strip
    surname = info[2].strip
    github = info[3].strip
    phone = info[4]&.strip
    telegram = info[5]&.strip
    email = info[6]&.strip
    student=Student.new(id: id, lastname: lastname, firstname: firstname, surname: surname, phone: phone, telegram: telegram, email: email, github: github)
    new(student)

  end
  
  def self.short_contact(phone, telegram, email)
    contacts = []
    contacts << "Телефон: #{phone}" unless phone.empty?
    contacts << "Telegram: #{telegram}" unless telegram.empty?
    contacts << "Email: #{email}" unless email.empty?
    contacts.join(', ')
  end
  
  def to_s
    "ФИО: #{@lastname_initials}, ID: #{@id}, Git: #{@github}, контакты: #{@contact}"
   end
  
  
end