require_relative 'human'

class Student_short < Human
  attr_reader :surname_initials, :contact

  def initialize(student)
    super(student.id, lastname: student.lastname, firstname: student.firstname, surname: student.surname,
          phone: student.phone, telegram: student.telegram, email: student.email, github: student.github)
    @surname_initials = "#{student.lastname} #{student.firstname[0]}. #{student.surname[0]}."
    @contact = get_contact(student)
  end

  def get_contact(student)
    contacts = []
    contacts << "Телефон: #{student.phone}" if student.phone
    contacts << "Telegram: #{student.telegram}" if student.telegram
    contacts << "Email: #{student.email}" if student.email

    contacts.empty? ? "Нет контактов" : contacts.join(', ')
  end

  def initialize_from_string(id, input)
    parts = input.split(';')
    raise ArgumentError, "Неверное количество параметров" unless parts.size >= 3

    lastname, firstname, surname, github, phone, telegram, email = parts.map(&:strip)
    super(id, lastname: lastname, firstname: firstname, surname: surname, phone: phone, telegram: telegram, email: email, github: github)
    @surname_initials = "#{lastname} #{firstname[0]}. #{surname[0]}."
    @contact = contact_info(phone, telegram, email)
  end

  def contact_info(phone, telegram, email)
    contacts = []
    contacts << "Телефон: #{phone}" if phone && !phone.empty?
    contacts << "Telegram: #{telegram}" if telegram && !telegram.empty?
    contacts << "Email: #{email}" if email && !email.empty?

    contacts.empty? ? "Нет контактов" : contacts.join(', ')
  end
end