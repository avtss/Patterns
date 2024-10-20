class Human
  attr_reader :id,  :github

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

  

  def no_contact?
    @phone.nil? && @telegram.nil? && @email.nil?
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

end