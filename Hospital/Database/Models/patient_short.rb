require_relative './human'
require_relative './patient'

class PatientShort < Human
  attr_reader :lastname_initials

  def initialize(lastname_initials, id:nil, phone:nil, card_number:nil)
    @lastname_initials = lastname_initials
    super(id: id, phone: phone, card_number: card_number)
  end

  def self.from_patient(patient)
    new(patient.fullname, patient.id, patient.phone, patient.card_number)
  end

  def self.from_string(id, input)
    info = input.split(", ")
    lastname_initials = info[0]
    phone = info[1] 
    card_number = info[2]
    new(lastname_initials, id: id, phone: phone, card_number: card_number)
  end
  
  private_class_method :new
end