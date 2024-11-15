class Human
  attr_reader :id,  :github

  def initialize(id: nil, github: nil)
		self.id = id if id
    self.github = github if github
	end
  
  GITHUB_REGEX = /^https?:\/\/github\.com\/[a-zA-Z0-9_-]+$/

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
    raise NotImplementedError, "Метод не реализован в классе Human"
  end

  def self.valid_name?(name)
    raise NotImplementedError, "Метод не реализован в классе Human"
  end

  def self.valid_email?(email)
    raise NotImplementedError, "Метод не реализован в классе Human"
  end

  def self.valid_telegram?(telegram)
    raise NotImplementedError, "Метод не реализован в классе Human" 
  end

  def self.valid_birthdate?(birthdate)
		raise NotImplementedError, "Метод не реализован в классе Human"
	end

  def has_contact?
  	raise NotImplementedError, "Метод не реализован в классе Human"
  end

  def has_git?
    !@github.nil?
  end

  def validate
    raise NotImplementedError, "Метод не реализован в классе Human"   
  end
end