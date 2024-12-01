require_relative './human'
require_relative './student'

class Student_short < Human
  attr_reader :lastname_initials, :contact

  def initialize(lastname_initials, id:nil, github:nil, contact:nil)
    @lastname_initials = lastname_initials
    @contact = contact
    super(id: id, github: github)
  end

  def self.from_student(student)
    new(student.fullname, id: student.id, github: student.github, contact: student.contact)
  end

  def self.from_string(id, input)
    info = input.split(", ")
    lastname_initials = info[0]
    github = info[1] 
    contact = info[2]
    new(lastname_initials, id: id, github: github, contact: contact)
  end
  
  def to_s
    "ФИО: #{@lastname_initials}, ID: #{@id}, Git: #{@github}, контакты: #{@contact}"
   end
  
   private_class_method :new
end