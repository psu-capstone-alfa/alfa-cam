# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


users = User.create!( [
  { :login => 'review', :name => 'Acred Reviewer', :roles => [:reviewer] },
  { :login => 'inst1', :name => 'Instructor 1' , :roles => [:instructor]},
  { :login => 'inst2', :name => 'Instructor Staff' , :roles => [:instructor, :staff]},
  { :login => 'staff', :name => 'Staff', :roles => [:staff]},
  { :login => 'admin', :name => 'Admin', :roles => [:admin]},
])

outcomes = Outcome.create!( [
  { key: 'A', title: "Outcome A", description: "I'm outcome A!!!" },
  { key: 'B', title: 'Outcome B', description: "I'm a B outcome..." },
  { key: 'C', title: 'C outcome with a longer title', description: "I have a long title to see how that works" },
  { key: 'D', title: 'Da Outcome', description: 'Duh, Outcome!' },
])

courses = Course.create!( [
  {dept_code: 'CEE', course_num: '101', title: 'Engineering for Dummies'},
  {dept_code: 'CEE', course_num: '161', title: 'Intro to Civil Engineering'},
  {dept_code: 'CEE', course_num: '201', title: 'Cull the Flock'}
])

outcome_groups = OutcomeGroup.create!( [
  { title: '1', outcomes: outcomes[0..2] },
  { title: '2', outcomes: outcomes },
])

year = Time.new.year
terms = AcademicTerm.create!( [
  {title: "Fall #{year}", outcome_group: outcome_groups.first},
  {title: "Winter #{year}", outcome_group: outcome_groups.first},
  {title: "Spring #{year}", outcome_group: outcome_groups.second},
  {title: "Summer #{year}", outcome_group: outcome_groups.second},
])

offerings = Offering.create!( [
  { course: courses[0], term: terms[0], instructors: [users[1]] },
  { course: courses[1], term: terms[0], instructors: [users[1]] },
  { course: courses[2], term: terms[1], instructors: [users[2],users[1]] },
])
