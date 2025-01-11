require_relative './human'
require 'date'

class Patient < Human
  include Comparable

  attr_reader :lastname, :firstname, :surname, :birth_date, :diagnosis, :doctor_id

  def initialize(lastname:, firstname:, surname:, id: nil, phone: nil, birth_date: nil, diagnosis: nil, doctor_id: nil, card_number: nil)
    @lastname = lastname
    @firstname = firstname
    @surname = surname
    @birth_date = birth_date if birth_date
    @diagnosis = diagnosis if diagnosis
    @doctor_id = doctor_id if doctor_id
    super(id: id, phone: phone, card_number: card_number)
  end

  def self.from_hash(hash)
    id = hash[:id]&.to_i
    lastname = hash[:lastname]&.strip
    firstname = hash[:firstname]&.strip
    surname = hash[:surname]&.strip
    phone = hash[:phone]&.strip&.empty? ? nil : hash[:phone]&.strip
    card_number = hash[:card_number]&.strip&.empty? ? nil : hash[:card_number]&.strip
    birth_date = hash[:birth_date]&.strip&.empty? ? nil : Date.parse(hash[:birth_date].strip) if hash[:birth_date]
    diagnosis = hash[:diagnosis]&.strip&.empty? ? nil : hash[:diagnosis]&.strip
    doctor_id = hash[:doctor_id]&.to_i || nil
    new(
      id: id,
      lastname: lastname,
      firstname: firstname,
      surname: surname,
      phone: phone,
      card_number: card_number,
      birth_date: birth_date,
      diagnosis: diagnosis,
      doctor_id: doctor_id
    )
  rescue ArgumentError => e
    raise "Ошибка: #{e.message}"
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