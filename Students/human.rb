class Human
  attr_reader :id,  :github

  def initialize(id: nil, github: nil)
		self.id = id if id
    self.github = github if github
	end

  GITHUB_REGEX = /^https?:\/\/github\.com\/[a-zA-Z0-9_-]+$/
  PHONE_REGEX = /^\+7\d{10}$/
  NAME_REGEX = /^[А-ЯЁ][а-яё]+\s*$/
  EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  TELEGRAM_REGEX = /^@\w{5,}$/
  
  private def github=(val)
    if self.class.valid_github?(val)
      @github=val
    else
      raise ArgumentError, "Некорректный Git"
    end
  end

  private def id=(val)
    if self.class.valid_id?(val)
      @id = val
    else
      raise ArgumentError, "Некорректный ID"
    end
  end

  def self.valid_id?(id)
		id.is_a?(Integer) && id > 0
	end

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
  	!@telegram.nil? || !@phone.nil? || !@email.nil?
  end

  def has_git?
    !@github.nil?
  end

  def validate
    has_contact? && has_git?   
  end
end