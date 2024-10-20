require_relative 'human'

class Student < Human
  attr_reader :lastname, :firstname, :surname, :phone, :telegram, :email

  def initialize(id:, lastname:, firstname:, surname:, phone: nil, telegram: nil, email: nil, github: nil)
    @id = id
    @lastname = lastname
    @firstname = firstname
    @surname = surname
    @phone = phone
    @telegram = telegram
    @email = email
    @github = github
    validate
  end

  
  def validate
    raise ArgumentError, "Необходимо указать GitHub" if @github.nil?
    raise ArgumentError, "Необходимо указать хотя бы один контакт для связи" if no_contact?

    raise ArgumentError, "Некорректный телефон" if @phone && !self.class.valid_phone?(@phone)
    raise ArgumentError, "Некорректный Telegram" if @telegram && !self.class.valid_telegram?(@telegram)
    raise ArgumentError, "Некорректная почта" if @email && !self.class.valid_email?(@email)
    raise ArgumentError, "Некорректное имя" if @name && !self.class.valid_name?(@name)
    raise ArgumentError, "Некорректный Git" if @github && !self.class.valid_github?(@github)
  end

  def get_info
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
  #Сеттеры для всех полей:
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

  def github=(val)
    if self.class.valid_github?(val)
      @github=val
    else
      raise ArgumentError, "Некорректный Git"
    end
  end

  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.class.valid_phone?(phone) ? (@email = phone) : (raise ArgumentError, "Некорректный номер телефона")
		self.class.valid_telegram?(telegram) ? (@telegram = telegram) : (raise ArgumentError, "Некорректный Telegram")
		self.class.valid_email?(email) ? (@phone_number = email) : (raise ArgumentError, "Некорректный email")
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


