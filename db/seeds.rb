# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

include RandomText

def random_time
  times = [
    "09:00-11:50", "12:00-13:50", "08:15-10:05", "16:40-18:30", "18:40-21:30",
    "14:00-15:50", "12:00-13:20", "10:00-11:50", "09:30-11:20", "12:45-14:35"
  ]
  times.sample
end

Factory.define :user do |f|
  f.name { Forgery::Name.full_name }
  f.login 'user %d'
  f.email 'nobody%d@nowhere.non'
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
    f.day_and_time { Forgery::Date.day_of_week << " " << random_time}
    f.textbook { Lorem.paragraph }
    f.additional_textbooks { Lorem.paragraphs(3).join "\n" }
    f.required_for_bsce { ["Required", "Elective", "n/a"].sample }
    f.required_for_bsenve { ["Required", "Elective", "n/a"].sample }
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

  def build_outcomes(range)
    range.map do |key|
      Outcome.create!(
        key: key,
        description: Lorem.paragraph
      )
    end
  end

  def initialize
    @ogroups = OutcomeGroup.create!( [
      { title: 'Original outcomes', outcomes: build_outcomes('A'..'C') },
      { title: 'New outcomes', outcomes: build_outcomes('A'..'K') },
    ])

    @ogroup = @ogroups.last

    cg_names = ['Lectures','Assignments','Labs','Projects / Papers','Other']
    @content_group_names = cg_names.map do |name|
      Factory :content_group_name, name: name
    end
    @lectures = @content_group_names[0]
    @assignments = @content_group_names[1]
  end

  def content_group_with_mappings(offering,name)
    cg = ContentGroup.create!(offering: offering, content_group_name: name)
    rand(2..5).repetitions {
      content_with_mappings(cg)
    }
    cg
  end

  def content_with_mappings(cg)
    c = Content.create! title: 'Some content', content_group: cg
    faked_content_mappings(c)
  end

  def faked_content_mappings(c)
    points = 10
    Mapping.import (c.offering.outcomes.map { |o|
      if o == c.offering.outcomes.last
        amt = points
      else
        amt = [rand(-30..points),0].max
      end
      points -= amt
      Mapping.new value: amt, outcome: o, mappable: c
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
    @content_group_names.each { |cg| content_group_with_mappings(offering, cg)}
    offering.save!
    offering
  end


  def objective_with_mappings(offering)
    objective = Factory :objective, offering: offering
    faked_objective_mapping(offering, objective)
  end

  def faked_objective_mapping(offering, objective)
    objective.mappings.create!(
      offering.outcomes.map do |out|
        {outcome: out, value: [rand(-1..1),0].max}
      end
    )
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
    #retired = Course.available_during(term).sample
    #retired.retired_term = term unless retired.nil?
    #Factory :course, created_term: term
    yield(term) if block_given?
    term
  end

  def build_initial_term
    # Build the first term
    puts "Building term: Initial w/ random courses"
    @initial_term = AcademicTerm.create! do |t|
      t.title = 'Fall 1900'
      t.outcome_group = @ogroup
    end

    # Seed it with a bunch of courses
    @courses = 5.repetitions { Factory :course, created_term: @initial_term }
    done_it_all_instructor = Factory :instructor, name: 'Done Everything'
    @courses.each do |course|
      build_completed_offering do |o|
        o.term = @initial_term
        o.course = course
        o.instructors = [done_it_all_instructor]
      end
    end
  end

  def build_current_term
    @current_term = build_term("Its #{Date.today.year}", @ogroup) do |term|
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

  def build_demo_term
    @current_term = build_term("Winter #{Date.today.year}", @ogroup) do |term|
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
      end
    end

    # Build our demo instructor a course/offering to copy from
    @course = Course.create!(
      dept_code: 'CS',
      course_num: '557',
      title: 'Modern Language Processors',
      created_term: @initial_term
    )
    @old_offering = Offering.create!(
      course: @course,
      term: @initial_term,
      instructors: [@demo_instructor]
    )
    details = {
      section: '1',
      crn: '12345',
      location: 'FAB 40-6',
      credits: '4',
      day_and_time: 'MW 1200-1400',
      required_for_bsce: 'Required',
      required_for_bsenve: 'Elective',
      prerequisites: '',
      textbook: 'Modern Languages Text',
      description: 'An awesome class!',
      details_done: true,
      review_done: true,
      importing_done: true,
    }
    @old_offering.update_attributes(details)
    objectives = [
      { description: 'Use and interpret scales, basic lettering, and do simple technical sketching.' },
      { description: 'Be able to transcribe a three dimensional object to a two-dimensional representation in an engineering drawing.' },
      { description: 'Be able to read and create simple common civil engineering drawings.' },
    ]
    @old_offering.update_attributes(objectives_attributes: objectives)
    @old_offering.objectives.each do |objective|
      faked_objective_mapping(@old_offering, objective)
    end

    content = [
      { content_group_name: @content_group_names[0], content_attributes: [
        { title: 'Orthographic projection' },
        { title: 'Sectioning' },
        { title: 'Dimensioning and tolerance' },
        ]
      },
      { content_group_name: @content_group_names[1], content_attributes: [
        { title: 'Section 2.3 from the text: problems 2,4,7,10' },
        { title: 'Chapter 3 end of chapter exercises 5, 10, 12' },
        { title: 'Problems 1.2, 1.7 and 1.8 from the study guide' },
        ]
      },
      { content_group_name: @content_group_names[2] },
      { content_group_name: @content_group_names[3] },
      { content_group_name: @content_group_names[4] },
    ]
    @old_offering.update_attributes(content_groups_attributes: content)
    @old_offering.content.each do |c|
      faked_content_mappings(c)
    end

    assessment = @old_offering.get_or_create_assessment
    assessment.update_attributes({
      comments: 'None',
      improved: 'Focus more on terminology in the beginning of the class as the material builds on it as the course progresses.',
    })

    oa = assessment.objective_assessments
    oa[0].update_attributes(
      assessed: 'Periodic homework assignments and 3 graded sketches during the term.',
      well_met: 'Students performed well at interpreting scales and basic lettering, but they struggled with the technical sketches.',
      improved: 'Spend more time on sketches and consider increasing the number of graded sketches.'
    )
    oa[1].update_attributes(
      assessed: 'Students submitted two transcribed drawings during the term.',
      well_met: 'Students seemed to perform well at this.',
      improved: 'N/A'
    )
    oa[2].update_attributes(
      assessed: '2 homework assignments covered reading and creating civil engineering drawings and both the midterm and the final had sections covering this topic.',
      well_met: 'Terminology was a sticking point. Many students struggled with even basic terminology on the midterm and final.',
      improved: 'N/A'
    )



    @old_offering.update_attributes(
      objectives_done: true,
      content_done: true,
      assessments_done: true
    )


    @new_offering = Offering.create!(
      course: @course,
      term: @current_term,
      instructors: [@demo_instructor]
    )

  end




  def run_the_seedening
    @instructors = []
    @instructors << @demo_instructor = Factory(:instructor,
      name: 'Instructor',
      login: 'inst',
      password: '1234')
    @staff = Factory :staff, name: 'Staff', login: 'staff', password: '1234'

    #@instructors.concat 2.repetitions { Factory :instructor }

    build_initial_term

    # Then build some years
    #build_old_year((Date.today.year - 1).to_s, @ogroup)
    build_demo_term
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
