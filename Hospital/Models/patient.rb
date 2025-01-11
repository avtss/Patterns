require_relative './human'
require 'date'

class Patient < Human
  include Comparable

  attr_reader :lastname, :firstname, :surname, :birth_date, :diagnosis, :doctor_id

  NAME_REGEX = /^[А-ЯЁ][а-яё]+\s*$/

  def initialize(lastname:, firstname:, surname:, id: nil, phone: nil, birth_date: nil, diagnosis: nil, doctor_id: nil)
    self.lastname = lastname
    self.firstname = firstname
    self.surname = surname
    self.birth_date = birth_date if birth_date
    self.diagnosis = diagnosis if diagnosis
    self.doctor_id = doctor_id if doctor_id
    super(id: id, phone: phone, card_number: card_number)
  end

  def self.from_hash(hash)
    id = hash[:id]&.to_i
    lastname = hash[:lastname]&.strip
    firstname = hash[:firstname]&.strip
    surname = hash[:surname]&.strip
    phone = hash[:phone]&.strip&.empty? ? nil : hash[:phone]&.strip
    birth_date = hash[:birth_date]&.strip&.empty? ? nil : Date.parse(hash[:birth_date].strip)
    diagnosis = hash[:diagnosis]&.strip&.empty? ? nil : hash[:diagnosis]&.strip
    doctor_id = hash[:doctor_id]&.to_i&.empty? ? nil : hash[:doctor_id]&.to_i
    new(id: id, lastname: lastname, firstname: firstname, surname: surname, phone: phone, birth_date: birth_date, diagnosis: diagnosis, doctor_id: doctor_id)
  rescue ArgumentError => e
    raise "Ошибка: #{e.message}"
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

  def ==(other)
    if @phone && other.phone && @phone == other.phone
      return true
    end
    return false
  end
end