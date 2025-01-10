class Human
  attr_reader :id, :phone, :card_number

  def initialize(id: nil, phone: nil, card_number: nil)
		self.id = id if id
    self.phone = phone if phone
    self.card_number = card_number if card_number
	end
  
  PHONE_REGEX = /^\+7\d{10}$/
  CARD_NUMBER_REGEX = /^\d{7}$/

  def id=(val)
    if self.class.valid_id?(val)
      @id = val
    else
      raise ArgumentError, "Некорректный ID"
    end
  end

  def phone=(val)
    if self.class.valid_phone?(val)
      @phone = val
    else
      raise ArgumentError, "Некорректный номер телефона"
    end
  end

  def card_number=(val)
    if self.class.valid_card_number?(val)
      @card_number = val
    else
      raise ArgumentError, "Некорректный номер карты"
    end
  end

  def self.valid_id?(id)
		id.is_a?(Integer) && id > 0
	end

  def self.valid_phone?(phone)
    phone =~ PHONE_REGEX
  end

  def self.valid_card_number?(card_number)
    phone =~ CARD_NUMBER_REGEX
  end

  def self.valid_name?(name)
    raise NotImplementedError, "Метод не реализован в классе Human"
  end

  def self.valid_birthdate?(birthdate)
		raise NotImplementedError, "Метод не реализован в классе Human"
	end

end