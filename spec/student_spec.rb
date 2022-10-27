require './lib/student'

RSpec.describe Student do
  it 'exists' do
    student = Student.new({name: "Morgan", age: 21})

    expect(student).to be_a Student
  end

  it 'has a name' do
    student = Student.new({name: "Morgan", age: 21})

    expect(student.name).to eq("Morgan")
  end

  it 'has an age' do
    student = Student.new({name: "Morgan", age: 21})

    expect(student.age).to eq(21)
  end

  it 'has an array of the scores that starts empty' do
    student = Student.new({name: "Morgan", age: 21})

    expect(student.scores).to eq([])
  end

  describe '#log_score' do
    it 'adds a score to the students scores array' do
      student = Student.new({name: "Morgan", age: 21})
      student.log_score(89)

      expect(student.scores).to eq([89])
      student.log_score(78)

      expect(student.scores).to eq([89, 78])
    end
  end

  describe '#grade' do
    it 'averages all of the scores' do
      student = Student.new({name: "Morgan", age: 21})
      student.log_score(89)
      expect(student.grade).to eq(89)
      student.log_score(78)

      expect(student.grade).to eq(83.5)
    end
  end

end
