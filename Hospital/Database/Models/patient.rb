require_relative './human'
require 'date'

class Patient < Human
  attr_reader :lastname, :firstname, :surname, :birth_date, :diagnosis

  NAME_REGEX = /^[А-ЯЁ][а-яё]+\s*$/

  def initialize(lastname:, firstname:, surname:, id: nil, phone: nil, birth_date: nil, diagnosis: nil)
    self.lastname = lastname
    self.firstname = firstname
    self.surname = surname
    self.birth_date = birth_date if birth_date
    self.diagnosis = diagnosis if diagnosis

    super(id: id, phone: phone, card_number: card_number)
  end

  def self.valid_name?(name)
    name =~ NAME_REGEX && !name.nil?
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

  def fullname
    "#{@lastname} #{@firstname[0]}.#{@surname[0]}."
  end
end