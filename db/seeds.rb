# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

include RandomText

Factory.define :user do |f|
  f.name { Forgery::Name.full_name }
  f.login 'user %d'
end

User::ROLES.each do |role|
  Factory.define role, parent: :user do |f|
    f.login "#{role}%d"
    f.roles [role]
  end
end

Factory.define :course do |f|
  f.dept_code { Forgery::University.course_subject }
  f.course_num { Random.new.rand(101..999) }
  f.title { Forgery::University.course_title }
  f.created_term { AcademicTerm.first }
  f.group { ('A'..'J').to_a.sample }
end

Factory.define :offering do |f|
end

Factory.define :detailed_offering, parent: :offering do |f|
    f.section '001'
    f.crn { Forgery::Extend("#####").to_numbers }
    f.location { Forgery::Address.street_name << " Hall" }
    f.credits { rand(1..6) }
    f.day_and_time { Forgery::Date.day_of_week }
    f.textbook { Lorem.paragraph }
    f.additional_textbooks { Lorem.paragraphs(3).join "\n" }
    f.required_or_elective { %w(Required Elective).sample }
    f.prerequisites { Factory.build(:course).to_s }
    f.description { Lorem.sentences(5).join ' ' }
end

Factory.define :objective do |f|
  f.description { Lorem.sentences(2).join ' ' }
end

Factory.define :content_group_name do |f|
  f.name { Forgery::University.content_group_name }
  f.active true
end

class Seederation
  include RandomText

  def initialize
    @outcomes = ('A'..'K').map do |key|
      Outcome.create! key: key,
        title: "Outcome #{key}",
        description: Lorem.sentence
    end

    @ogroups = OutcomeGroup.create!( [
      { title: 'Original outcomes', outcomes: @outcomes[0..8] },
      { title: 'New outcomes', outcomes: @outcomes },
    ])

    @content_group_names = 3.repetitions { Factory :content_group_name }
  end

  def content_group_with_mappings(offering)
    cg = ContentGroup.create!(offering: offering, content_group_name: @content_group_names.sample)
    Random.new.rand(2..10).repetitions {
      content_with_mappings(cg)
    }
    cg
  end

  def content_with_mappings(cg)
    c = Content.create! title: 'Some content', content_group: cg
    Mapping.import (c.outcomes.map { |o|
      Mapping.new value: Random.new.rand(0..10), outcome: o, mappable: c
    })
    c.save!
  end

  def assessment_for_offering(offering)
    assessment = offering.create_assessment!
    assessment.improved = Lorem.paragraph
    assessment.comments = Lorem.paragraph
    assessment.objective_assessments.each do |obj|
      obj.assessed = Lorem.paragraph
      obj.well_met = Lorem.paragraph
      obj.improved = Lorem.paragraph
      obj.save!
    end
  end

  def build_completed_offering(&blk)
    offering = build_started_offering(&blk)
    offering.objectives_done = true
    offering.content_done = true
    offering.assessments_done = true
    assessment_for_offering(offering)
    offering.save!
    offering
  end

  def build_started_offering
    attrs = Factory.build(:detailed_offering).attributes
    offering = Offering.create!(attrs) do |o|
      yield(o) if block_given?
      o.review_done = true
      o.importing_done = true
      o.details_done = true
    end
    5.repetitions { objective_with_mappings(offering) }
    3.repetitions { content_group_with_mappings(offering) }
    offering.save!
    offering
  end


  def objective_with_mappings(offering)
    objective = Factory :objective, offering: offering
    objective.mappings.create!(offering.outcomes.map {|out| {outcome: out}})
  end

  def build_old_year(year,outcome_group)
  %w(Winter Spring Summer Fall).each do |term|
    build_term("#{term} #{year}",outcome_group) do |term|
      courses = term.available_courses
      @instructors.each do |instructor|
        2.times do
          build_completed_offering do |o|
            o.term = term
            o.course = courses.sample
            o.instructors = [instructor]
          end
        end
      end
    end
  end
end

  def build_term(title,outcome_group)
    puts "Building term: #{title}"
    term = AcademicTerm.create! title: title, outcome_group: outcome_group
    retired = Course.available_during(term).sample
    retired.retired_term = term unless retired.nil?
    Factory :course, created_term: term
    yield(term) if block_given?
    term
  end

  def build_initial_term
    # Build the first term
    @initial_term = AcademicTerm.create! do |t|
      t.title = 'Initial'
      t.outcome_group = @ogroups[0]
    end

    # Seed it with a bunch of courses
    50.times { Factory :course, created_term: @initial_term }
  end

  def build_current_term
    @current_term = build_term("Its #{Date.today.year}", @ogroups[0]) do |term|
      courses = term.available_courses
      @instructors.each do |instructor|
        build_completed_offering do |o|
          o.term = term
          o.course = courses.sample
          o.instructors = [instructor]
        end
        build_started_offering do |o|
          o.term = term
          o.course = courses.sample
          o.instructors = [instructor]
        end
        Factory :offering,
          term: term,
          course: courses.sample,
          instructors: [instructor]
      end
    end
  end



  def run_the_seedening
    @instructors = []
    @instructors << Factory(:user,
      login: 'inst-staff',
      roles: [:staff, :instructor],
      name: 'Staff Instructor TEST')
    @instructors << Factory(:instructor, name: 'Instructor TEST')

    @staff = Factory :staff,  name: 'Staff TEST'
    @admin = Factory :admin, name: 'Admin TEST'
    @reviewer = Factory :reviewer, name: 'Reviewer TEST'

    @instructors.concat 10.repetitions { Factory :instructor }

    build_initial_term

    # Then build some years
    # build_old_year((Date.today.year - 1).to_s, @ogroups[0])
    build_current_term
  end

end


Seederation.new.run_the_seedening






=begin
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

courses = Course.create!( [
  {dept_code: 'CEE', course_num: '101', title: 'Engineering for Dummies', group: 'One Test', created_term: terms[0]},
  {dept_code: 'CEE', course_num: '161', title: 'Intro to Civil Engineering', group: 'Two Beta', created_term: terms[0]},
  {dept_code: 'CEE', course_num: '201', title: 'Cull the Flock', group: 'Two Beta', created_term: terms[0]}
])


offerings = Offering.create!( [
  { course: courses[0], term: terms[0], instructors: instructors[0,0], section: '001', crn: '987665', credits: '3', day_and_time: "TR 9:00am - 10:30am", textbook: "Hydrology 101", additional_textbooks: "Another textbook", required_or_elective: "required for BSCE", prerequisites: "CE 101, CE 201", location: "FAB-098" },
  { course: courses[1], term: terms[0], instructors: instructors[0,1], section: '002', crn: '655432', credits: '3', day_and_time: "MW 12:00pm - 1:30pm", textbook: "Traffic flow", additional_textbooks: "Grin and bear it", required_or_elective: "required for BSENVE", prerequisites: "CE 514", location: "NEU-201" },
  { course: courses[2], term: terms[1], instructors: instructors[0..2], section: '001', crn: '322134', credits: '4', day_and_time: "M 8:00am - 11a.m.", textbook: "Asphalt Substrate", additional_textbooks: "Berenstein Bears Create A Road", required_or_elective: "required for BSCE and BSENVE", location:"REC-123" }
])

objectives = Objective.create!([
  {offering: offerings[0], description: "Course Overview"},
  {offering: offerings[0], description: "Microbes and You"},
  {offering: offerings[1], description: "Chemical Principles"},
  {offering: offerings[1], description: "Cell Structure"},
])
=end
