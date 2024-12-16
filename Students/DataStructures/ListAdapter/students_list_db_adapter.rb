require_relative './adapter.rb'

class Students_list_db_adapter < Adapter
  def initialize(db_config)
    @db = DB_Connection.instance(db_config)
  end
  
  def find_student_by_id(id)
    result = @db.execute_query("SELECT * FROM student WHERE id = #{id}")
    return nil if result.ntuples == 0
    row = result[0]
  
    Student.from_hash(
      id: row['id'],
      lastname: row['last_name'],
      firstname: row['first_name'],
      surname: row['surname'],
      phone: row['phone'],
      email: row['email'],
      telegram: row['telegram'],
      github: row['github'],
      birth_date: row['birth_date']
    )
  end
  
  def get_k_n_student_short_list(k, n, filter = nil)
    start_index = (k - 1) * n + 1
    end_index = start_index + n - 1
    query = "
      SELECT * FROM student
      WHERE id BETWEEN #{start_index} AND #{end_index}
    "
    result = @db.execute_query(query)
    students = result.map do |row|
      Student.from_hash(
        id: row['id'],
        lastname: row['last_name'],
        firstname: row['first_name'],
        surname: row['surname'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        github: row['github'],
        birth_date: row['birth_date']
      )
    end

    students = filter.apply_filter(students) if filter
  
    short_students = students.map { |student| Student_short.from_student(student) }
  
    selected_list = Data_list_student_short.new(short_students)
    short_students.each_with_index { |_, index| selected_list.select(index) }
    selected_list
  end
  
  def add_student(student)
    query = "
      INSERT INTO student (last_name, first_name, surname, phone, email, telegram, github, birth_date)
      VALUES ('#{student.lastname}', '#{student.firstname}', '#{student.surname}', 
              #{student.phone.nil? ? 'NULL' : "'#{student.phone}'"},
              #{student.email.nil? ? 'NULL' : "'#{student.email}'"},
              #{student.telegram.nil? ? 'NULL' : "'#{student.telegram}'"},
              #{student.github.nil? ? 'NULL' : "'#{student.github}'"},
              '#{student.birth_date}')
    "
    @db.execute_query(query)
  end

  def update_student_by_id(id, updated_student)
    query = "
      UPDATE student
      SET last_name = '#{updated_student.lastname}',
          first_name = '#{updated_student.firstname}',
          surname = '#{updated_student.surname}',
          phone = #{updated_student.phone.nil? ? 'NULL' : "'#{updated_student.phone}'"},
          email = #{updated_student.email.nil? ? 'NULL' : "'#{updated_student.email}'"},
          telegram = #{updated_student.telegram.nil? ? 'NULL' : "'#{updated_student.telegram}'"},
          github = #{updated_student.github.nil? ? 'NULL' : "'#{updated_student.github}'"},
          birth_date = '#{updated_student.birth_date}'
      WHERE id = #{id}
    "
    @db.execute_query(query)
  end

  def delete_student_by_id(id)
    @db.execute_query("DELETE FROM student WHERE id = #{id}")
  end

  def get_student_short_count(filter = nil)
    query = 'SELECT * FROM student'
    result = @db.execute_query(query)
  
    students = result.map do |row|
      Student.from_hash(
        id: row['id'],
        lastname: row['last_name'],
        firstname: row['first_name'],
        surname: row['surname'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        github: row['github'],
        birth_date: row['birth_date']
      )
    end
  
    filtered_students = filter ? filter.apply_filter(students) : students
  
    filtered_students.size
  end
end