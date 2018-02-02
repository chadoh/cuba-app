require "sqlite3"

class Student
  attr_accessor :id, :name, :email, :discord

  DB = SQLite3::Database.new "./db/dev.db"

  def initialize(id, name, email, discord)
    @id = id
    @name = name
    @email = email
    @discord = discord
  end

  def self.all
    student_array = DB.execute("SELECT * FROM students")
    student_array.map do |id, name, email, discord|
      Student.new(id, name, email, discord)
    end
  end
end
