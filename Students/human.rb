class Human
  attr_reader :id,  :github


  GITHUB_REGEX = /^https?:\/\/github\.com\/[a-zA-Z0-9_-]+$/
  PHONE_REGEX = /^\+7\d{10}$/
  NAME_REGEX = /^[А-ЯЁ][а-яё]+\s*$/
  EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  TELEGRAM_REGEX = /^@\w{5,}$/
  

  def self.valid_github?(github)
    github =~ GITHUB_REGEX
  end

   def self.valid_phone?(phone)
    phone =~ PHONE_REGEX
  end

  def self.valid_name?(name)
    name =~ NAME_REGEX && !name.nil?
  end

  def self.valid_email?(email)
    email =~ EMAIL_REGEX 
  end

   def self.valid_telegram?(telegram)
    telegram =~ TELEGRAM_REGEX 
  end

  def has_contact?
    raise NotImplementedError, "Метод не реализован в Human"
  end

  def has_git?
    !@github.nil?
  end

  def validate
    raise ArgumentError, "Не указан контакт" unless has_contact?
    raise ArgumentError, "Не указан GitHub" unless has_git?
    true
  end


end