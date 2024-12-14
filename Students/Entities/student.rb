require_relative './human'
require 'date'

class Student < Human
  include Comparable

  attr_reader :lastname, :firstname, :surname, :phone, :telegram, :email, :birth_date

  PHONE_REGEX = /^\+7\d{10}$/
  NAME_REGEX = /^[А-ЯЁ][а-яё]+\s*$/
  EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  TELEGRAM_REGEX = /^@\w{3,}$/

  def initialize(lastname:, firstname:, surname:, id: nil, phone: nil, telegram: nil, email: nil, github: nil, birth_date: nil)
    self.lastname = lastname
    self.firstname = firstname
    self.surname = surname
    self.birth_date = birth_date if birth_date
    set_contacts(phone: phone, telegram: telegram, email: email)
    super(id: id, github: github)
  end

  def self.from_string(input)
    info = input.split(';')
    raise ArgumentError, "Неверное количество параметров" unless info.size >= 8
    id = info[0].strip.to_i
    lastname = info[1].strip
    firstname = info[2].strip
    surname = info[3].strip
    phone = info[4].strip.empty? ? nil : info[4].strip
    telegram = info[5].strip.empty? ? nil : info[5].strip
    email = info[6].strip.empty? ? nil : info[6].strip
    github = info[7].strip.empty? ? nil : info[7].strip
    birth_date = info[8].strip.empty? ? nil : Date.parse(info[8].strip)
    new(id: id, lastname: lastname, firstname: firstname, surname: surname, phone: phone, telegram: telegram, email: email, github: github, birth_date: birth_date)
  rescue ArgumentError => e
    raise "Ошибка: #{e.message}"
  end

  def self.from_hash(hash)
    id = hash[:id]&.to_i
    lastname = hash[:lastname]&.strip
    firstname = hash[:firstname]&.strip
    surname = hash[:surname]&.strip
    phone = hash[:phone]&.strip&.empty? ? nil : hash[:phone]&.strip
    telegram = hash[:telegram]&.strip&.empty? ? nil : hash[:telegram]&.strip
    email = hash[:email]&.strip&.empty? ? nil : hash[:email]&.strip
    github = hash[:github]&.strip&.empty? ? nil : hash[:github]&.strip
    birth_date = hash[:birth_date]&.strip&.empty? ? nil : Date.parse(hash[:birth_date].strip)
    new(id: id, lastname: lastname, firstname: firstname, surname: surname, phone: phone, telegram: telegram, email: email, github: github, birth_date: birth_date)
  rescue ArgumentError => e
    raise "Ошибка: #{e.message}"
  end

  def to_s
    contact_info = []
    contact_info << "телефон: #{@phone}" if @phone
    contact_info << "telegram: #{@telegram}" if @telegram
    contact_info << "email: #{@email}" if @email
    birth_info = "дата рождения: #{@birth_date}" if @birth_date

    "Студент: #{@lastname} #{@firstname} #{@surname}, ID: #{@id}, #{birth_info}, #{contact_info.join(', ')}, GitHub: #{@github}"
  end
  
  def self.valid_phone?(phone)
    phone =~ PHONE_REGEX
  end

  def self.valid_name?(name)
    name =~ NAME_REGEX && !name.nil?
  end

  def self.valid_email?(email)
    email =~ EMAIL_REGEX 
  end

  def self.valid_telegram?(telegram)
    telegram =~ TELEGRAM_REGEX 
  end

  def self.valid_birthdate?(birthdate)
		birthdate =~ BIRTHDATE_REGEX
	end

  def lastname=(val)
		if self.class.valid_name?(val)
			@lastname = val
		else
			raise ArgumentError, "Некорректная фамилия"
		end
	end

	def firstname=(val)
		if self.class.valid_name?(val)
			@firstname = val
		else
			raise ArgumentError, "Некорректное имя"
		end
	end

	def surname=(val)
		if self.class.valid_name?(val)
			@surname = val
		else
			raise ArgumentError, "Некорректное отчество"
		end
	end

  def birth_date=(val)
    @birth_date = Date.parse(val.to_s)
  rescue ArgumentError
    raise ArgumentError, "Некорректная дата рождения. Ожидаемый формат: ГГГГ-ММ-ДД или объект Date"
  end

  def set_contacts(phone: nil, telegram: nil, email: nil)
    if phone && self.class.valid_phone?(phone)
      @phone = phone
    elsif phone
      raise ArgumentError, "Некорректный номер телефона"
    end

    if telegram && self.class.valid_telegram?(telegram)
      @telegram = telegram
    elsif telegram
      raise ArgumentError, "Некорректный Telegram"
    end

    if email && self.class.valid_email?(email)
      @email = email
    elsif email
      raise ArgumentError, "Некорректный email"
    end
  end

  def has_contact?
  	!@telegram.nil? || !@phone.nil? || !@email.nil?
  end

  def validate
    has_contact? && has_git?   
  end
  
  def fullname
    "#{@lastname} #{@firstname[0]}.#{@surname[0]}."
  end

  def contact
    return "#{phone}" if phone
    return "#{email}" if email
    return "#{telegram}" if telegram
  end

  def <=>(other)
    other.birth_date <=> self.birth_date
  end

  def ==(other)
    if @phone && other.phone && @phone == other.phone || @github && other.github && @github == other.github || @email && other.email && @email == other.email || @telegram && other.telegram && @telegram == other.telegram
      return true
    end
    return false
  end
end


