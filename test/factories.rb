

Factory.define :course do |f|
  f.dept_code 'CS'
  f.course_num '%d'
  f.title 'A course title'
end

Factory.define :academic_term do |f|
  f.title 'Term %d'
end

Factory.define :offering do |f|
  f.term { Factory :academic_term }
  f.course { Factory :course }
end


