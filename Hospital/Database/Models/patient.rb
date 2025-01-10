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
end