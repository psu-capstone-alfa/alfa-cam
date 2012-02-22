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

courses = Course.create!( [
  {dept_code: 'CEE', course_num: '101', title: 'Engineering for Dummies', group: 'One Test', created_term: terms[0]},
  {dept_code: 'CEE', course_num: '161', title: 'Intro to Civil Engineering', group: 'Two Beta', created_term: terms[0]},
  {dept_code: 'CEE', course_num: '201', title: 'Cull the Flock', group: 'Two Beta',created_term: terms[0]}
])

offerings = Offering.create!( [
  { course: courses[0], term: terms[0], instructors: [users[1]], section: '001', crn: '987665', credits: '3', day_and_time: "TR 9:00am - 10:30am", textbook: "Hydrology 101", additional_textbooks: "Another textbook", required_or_elective: "required for BSCE", prerequisites: "CE 101, CE 201", location: "FAB-098" },
  { course: courses[1], term: terms[0], instructors: [users[1]], section: '002', crn: '655432', credits: '3', day_and_time: "MW 12:00pm - 1:30pm", textbook: "Traffic flow", additional_textbooks: "Grin and bear it", required_or_elective: "required for BSENVE", prerequisites: "CE 514", location: "NEU-201" },
  { course: courses[2], term: terms[1], instructors: [users[2],users[1]], section: '001', crn: '322134', credits: '4', day_and_time: "M 8:00am - 11a.m.", textbook: "Asphalt Substrate", additional_textbooks: "Berenstein Bears Create A Road", required_or_elective: "required for BSCE and BSENVE", location:"REC-123" }
])

objectives = Objective.create!([
  {offering_id: offerings[0].id, description: "Course Overview"},
  {offering_id: offerings[0].id, description: "Microbes and You"},
  {offering_id: offerings[1].id, description: "Chemical Principles"},
  {offering_id: offerings[1].id, description: "Cell Structure"},
])
