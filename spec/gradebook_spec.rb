require './lib/student'
require './lib/course'
require './lib/gradebook'


RSpec.describe Gradebook do
  it 'exists' do
    gradebook = Gradebook.new("Mr. Smith")

    expect(gradebook).to be_a Gradebook
  end

  it 'has an instructor' do
    gradebook = Gradebook.new("Mr. Smith")

    expect(gradebook.instructor).to eq("Mr. Smith")
  end

  it 'starts with an empty array of courses' do
    gradebook = Gradebook.new("Ms. Smith")

    expect(gradebook.courses).to eq([])
  end

  describe '#add_course' do
    it 'adds a course to the gradebook' do
      gradebook = Gradebook.new("Ms. Smith")
      course_1 = Course.new("Calculus", 2)
      gradebook.add_course(course_1)

      expect(gradebook.courses).to eq([course_1])
      course_2 = Course.new("Pre-Calc", 4)
      gradebook.add_course(course_2)

      expect(gradebook.courses).to eq([course_1, course_2])
    end
  end

  describe '#all_students' do
    it 'adds all students in a course to the gradebook' do
      gradebook = Gradebook.new("Ms. Smith")
      course_1 = Course.new("Calculus", 2)
      course_2 = Course.new("Pre-Calc", 4)
      student_1 = Student.new({name: "Morgan", age: 21})
      student_2 = Student.new({name: "Jorge", age: 35})
      student_3 = Student.new({name: "Iyayi", age: 29})
      gradebook.add_course(course_1)
      gradebook.add_course(course_2)
      gradebook.all_students

      expect(gradebook.students).to eq([])
      course_1.enroll(student_1)
      course_1.enroll(student_2)
      course_2.enroll(student_3)
      gradebook.all_students

      expect(gradebook.students).to eq([student_1, student_2, student_3])
    end

    it 'does not repeat students even if they are enrolled in multiple courses in the gradebook' do
      gradebook = Gradebook.new("Ms. Smith")
      course_1 = Course.new("Calculus", 2)
      course_2 = Course.new("Pre-Calc", 4)
      student_1 = Student.new({name: "Morgan", age: 21})
      student_2 = Student.new({name: "Jorge", age: 35})
      student_3 = Student.new({name: "Iyayi", age: 29})
      gradebook.add_course(course_1)
      gradebook.add_course(course_2)
      course_1.enroll(student_1)
      course_1.enroll(student_2)
      course_2.enroll(student_3)
      course_2.enroll(student_1)
      gradebook.all_students

      expect(gradebook.students).to eq([student_1, student_2, student_3])
    end
  end

  describe '#grade_check' do
    it 'returns list of students below given grade' do
      gradebook = Gradebook.new("Ms. Smith")
      course_1 = Course.new("Calculus", 2)
      course_2 = Course.new("Pre-Calc", 4)
      student_1 = Student.new({name: "Morgan", age: 21})
      student_2 = Student.new({name: "Jorge", age: 35})
      student_3 = Student.new({name: "Iyayi", age: 29})
      gradebook.add_course(course_1)
      gradebook.add_course(course_2)
      course_1.enroll(student_1)
      course_1.enroll(student_2)
      course_2.enroll(student_3)
      student_1.log_score(65)
      student_2.log_score(92)
      student_3.log_score(89)

      expect(gradebook.grade_check(40)).to eq([])
      expect(gradebook.grade_check(70)).to eq([student_1])

      student_1.log_score(100)
      student_2.log_score(50)
      student_3.log_score(25)

      expect(gradebook.grade_check(75)).to eq([student_2, student_3])
    end
  end
end
