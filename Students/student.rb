require_relative 'human'

class Student < Human
  attr_reader :lastname, :firstname, :surname, :phone, :telegram, :email

  def initialize(lastname:, firstname:, surname:, id: nil, phone: nil, telegram: nil, email: nil, github: nil)
    self.lastname = lastname
    self.firstname = firstname
    self.surname = surname
    set_contacts(phone: phone, telegram: telegram, email: email)
    super(id: id, github: github)
  end

  def self.from_string(input)
    info = input.split(';')
    raise ArgumentError, "Неверное количество параметров" unless info.size >= 5
    id = info[0].strip.to_i
    lastname = info[1].strip
    firstname = info[2].strip
    surname = info[3].strip
    phone = info[4].strip.empty? ? nil : info[4].strip
    telegram = info[5].strip.empty? ? nil : info[5].strip
    email = info[6].strip.empty? ? nil : info[6].strip
    github = info[7].strip.empty? ? nil : info[7].strip
    new(id: id, lastname: lastname, firstname: firstname, surname: surname, phone: phone, telegram: telegram, email: email, github: github)
  rescue ArgumentError => e
    raise "Ошибка: #{e.message}"
  end

  def to_s
    contact_info = []
    contact_info << "телефон: #{@phone}" if @phone
    contact_info << "telegram: #{@telegram}" if @telegram
    contact_info << "email: #{@email}" if @email

    "Студент: #{@lastname} #{@firstname} #{@surname}, ID: #{@id}, #{contact_info.join(', ')}, GitHub: #{@github}"
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

  def fullname
    "#{@lastname} #{@firstname[0]}.#{@surname[0]}."
  end

  def contact
    return "#{phone}" if phone
    return "#{email}" if email
    return "#{telegram}" if telegram
  end
end


