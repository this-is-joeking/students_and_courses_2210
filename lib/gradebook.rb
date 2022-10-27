class Gradebook
  attr_reader :instructor,
              :courses,
              :students

  def initialize(instructor)
    @instructor = instructor
    @courses = []
    @students =[]
  end

  def add_course(course)
    courses << course
  end

  def all_students
    courses.map do |course|
      course.students.each do |student|
        if students.include?(student) == false
          students << student
        end
      end
    end
  end

  def grade_check(grade)
    all_students
    students.select {|student| student.grade <= grade}
  end
end
