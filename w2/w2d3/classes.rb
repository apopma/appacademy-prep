class Student
  attr_reader :fname, :lname
  attr_accessor :courses
  
  def initialize(first_name, last_name)
    @courses = {}
    @fname = first_name
    @lname = last_name
  end
  
  def name
    "#{@fname} #{@lname}"
  end
  
  def courses
    @courses.keys
  end
  
  def enroll(course)
    @courses.values.each do |existing_course|
      if existing_course.conflicts_with?(course)
        raise StandardError,
        "#{existing_course.name} conflicts with #{course.name}"
      end
    end
    
    @courses[course.name] = course
    course.students << self.name
  end
  
  def course_load
    courseload = {}
    @courses.values.each do |course|
      courseload[course.dept] = course.credits
    end
    courseload
  end
  
  #def has_conflict?(course1, course2)
  #  course1.conflicts_with?(course2)
  #end
end


class Course
  attr_reader :name, :dept, :credits, :meeting_days, :meeting_time
  attr_accessor :students
  
  def initialize(course_name, department, credits, meeting_days, meeting_time)
    @students = []
    @name = course_name
    @dept = department
    @credits = credits
    @meeting_days = meeting_days
    @meeting_time = meeting_time
  end
  
  def students
    @students
  end
  
  def add_student(student)
    student.enroll(self)
  end
  
  def conflicts_with?(other_course)
    time_conflict = self.meeting_time == other_course.meeting_time
    date_conflict = self.meeting_days.any? do |day|
      other_course.meeting_days.include?(day)
    end
    
    time_conflict && date_conflict
  end
end


# ==============================================================================


billy = Student.new("Billy", "Budd")
eng101 =  Course.new("ENG101", "English", 3,
                    [:mon, :wed, :fri], 1)
                    
cs101  =  Course.new("CS101", "Computer Science", 4,
                    [:tue, :thu], 6)
                    
soc115 =  Course.new("SOC115", "English", 2,
                    [:tue, :sat, :sun], 4)
                    
chem126 = Course.new("CHEM126", "Chemistry", 3,
                    [:mon, :tue, :wed, :fri], 6)
                    
phys223 = Course.new("PHYS223", "Physics", 4,
                      [:mon, :wed, :fri], 4)


billy.enroll(eng101)
cs101.add_student(billy)

p billy.courses
p billy.course_load

p eng101.conflicts_with?(soc115)  #should be false, neither time nor date
p eng101.conflicts_with?(chem126) #should be false, date but not time
p phys223.conflicts_with?(soc115) #should be false, time but not date
p cs101.conflicts_with?(chem126)  #should be true, both time and date

billy.enroll(chem126) #should raise an error