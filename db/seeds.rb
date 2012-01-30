# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!( [
  { :login => 'user',  :name => 'Some User' },
  { :login => 'inst1', :name => 'Instructor 1' },
  { :login => 'inst2', :name => 'Instructor 2' },
  { :login => 'staff', :name => 'Staff' },
  { :login => 'admin', :name => 'Admin' },
])

Outcome.create!( [
  { key: 'A', title: "Outcome A", description: "I'm outcome A!!!" },
  { key: 'B', title: 'Outcome B', description: "I'm a B outcome..." },
  { key: 'C', title: 'C outcome with a longer title', description: "I have a long title to see how that works" },
])

year = Time.new.year
terms = AcademicTerm.create!( [
  {:title => "Fall #{year}"},
  {:title => "Winter #{year}"},
  {:title => "Spring #{year}"},
  {:title => "Summer #{year}"},
])

courses = Course.create!( [
  {dept_code: 'CEE', course_num: '101', title: 'Engineering for Dummies'},
  {dept_code: 'CEE', course_num: '161', title: 'Intro to Civil Engineering'},
  {dept_code: 'CEE', course_num: '201', title: 'Cull the Flock'}
])

