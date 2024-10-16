class Human
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

  def phone=(number)
    validate_phone(number)
    @phone = number
  end

  def lastname=(name)
    validate_name(name)
    @lastname = name
  end

  def firstname=(name)
    validate_name(name)
    @firstname = name
  end

  def surname=(name)
    validate_name(name)
    @surname = name
  end

  def email=(email)
    validate_email(email)
    @emal = email
  end

  def github=(git)
    validate_github(git)
    @github = git
  end

  def telegram=(username)
    validate_telegram(username)
    @telegram = username
  end

  def no_contact?
    @phone.nil? && @telegram.nil? && @email.nil?
  end

  def validate
    raise ArgumentError, "Необходимо указать GitHub" if @github.nil?
    raise ArgumentError, "Необходимо указать хотя бы один контакт для связи" if no_contact?
  end

  def to_s
    contact_info = []
    contact_info << "Телефон: #{@phone}" if @phone
    contact_info << "Telegram: #{@telegram}" if @telegram
    contact_info << "Email: #{@email}" if @email
    contact_info << "GitHub: #{@github}" if @github

    "Студент: #{@lastname} #{@firstname} #{@surname}, ID: #{@id}, Контакты: #{contact_info.join(', ')}"
  end

  def self.from_string(input)
    parts = input.split(';')
    raise ArgumentError, "Неверное количество параметров" unless parts.size >= 5

    id = parts[0].strip.to_i
    lastname = parts[1].strip
    firstname = parts[2].strip
    surname = parts[3].strip
    phone = parts[4].strip.empty? ? nil : parts[4].strip
    telegram = parts[5].strip.empty? ? nil : parts[5].strip
    email = parts[6].strip.empty? ? nil : parts[6].strip
    github = parts[7].strip.empty? ? nil : parts[7].strip

    new(id: id, lastname: lastname, firstname: firstname, surname: surname, phone: phone, telegram: telegram, email: email, github: github)
  rescue ArgumentError => e
    raise "Ошибка парсинга строки: #{e.message}"
  end

  private

  def validate_phone(phone)
    raise ArgumentError, "Некорректный номер телефона" unless self.class.valid_phone?(phone)
  end

  def validate_name(name)
    raise ArgumentError, "Некорректная фамилия" unless self.class.valid_name?(name)
  end

  def validate_email(email)
    raise ArgumentError, "Некорректный email" unless self.class.valid_email?(email)
  end

  def validate_github(git)
    raise ArgumentError, "Некорректный GitHub" unless self.class.valid_github?(git)
  end

  def validate_telegram(username)
    raise ArgumentError, "Некорректный Telegram" unless self.class.valid_telegram?(username)
  end
end

class Student < Human
  def set_contacts(phone: nil, telegram: nil, email: nil, github: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
    self.github = github if github
  end

  def getInfo
    initials = "#{@firstname[0]}. #{@surname[0]}."
    contact_info = if @phone
                     "Телефон: #{@phone}"
                   elsif @telegram
                     "Telegram: #{@telegram}"
                   elsif @email
                     "Email: #{@email}"
                   else
                     "Нет контактов"
                   end

    "#{@lastname} #{initials}; GitHub: #{@github}; #{contact_info}"
  end

  def fullname
    "#{@lastname}. #{@firstname[0]}. #{@surname[0]}"
  end

  def contact_method
    if @phone
      "Телефон: #{@phone}"
    elsif @telegram
      "Telegram: #{@telegram}"
    elsif @email
      "Email #{@email}"
    else
      "Нет контактов"
    end
  end
end

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
