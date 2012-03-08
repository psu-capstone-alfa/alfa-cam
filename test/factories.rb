# Collects factories for creating diffrent valid mock objects for testing

=begin Factory examples

Factory.define :something do |f|
  f.some_attribute 'A string with increment %d'
  f.an_int 123
  f.assocation { Factory :other_thing }
end

Factory.define :base do |f|
  f.one = 1
end

Factory.define :second, parent: :base do |f|
  # f.one = 1 from :base automatically
  f.two = 2
end

Factory.define :admin, class: :user do |f|
  # Uses the User model but the factory is called admin
end

=end


Factory.define :course do |f|
  f.dept_code 'CS'
  f.course_num '%d'
  f.title 'A course title'
  f.created_term { Factory :term }
end

Factory.define :academic_term do |f|
  f.title 'Term %d'
  f.outcome_group { Factory :outcome_group }
end

Factory.define :term, parent: :academic_term do |f|
end

Factory.define :offering do |f|
  f.term { Factory :academic_term }
  f.course { Factory :course }
end

Factory.define :user do |f|
  f.login 'user%d'
  f.name 'User McUserton'
  f.roles []
end

Factory.define :admin, class: :user do |f|
  f.login 'admin%d'
  f.name 'Admin'
  f.roles [:admin]
end

Factory.define :instructor, class: :user do |f|
  f.login 'inst%d'
  f.name 'Instructor'
  f.roles [:instructor]
end

Factory.define :outcome do |f|
  f.title 'Outcome %d'
  f.key '%d'
  f.description 'Outcome description %d'
end

Factory.define :outcome_group do |f|
  f.outcomes { 3.repetitions { Factory :outcome } }
end

Factory.define :content_group_name do |f|
      f.name { 'Group %d' }
  f.active true
end

Factory.define :content_group do |f|
  f.content_group_name { Factory :content_group_name }
  f.offering { Factory :offering }
end

Factory.define :mapping do |f|
  f.outcome { Factory :outcome }
  f.value { Random.new.rand(0..10) }
end

Factory.define :objective do |f|
  f.description 'Objective description %d'
end

Factory.define :content do |f|
  f.title 'Content %d'
end

Factory.define :course_replacement do |f|
end

Factory.define :teaching do |f|
  f.instructor { Factory :user }
  f.offering { Factory :offering }
end

Factory.define :mapping do |f|
  f.outcome { Factory :outcome }
  f.value { Random.new.rand(0..10) }
end

Factory.define :objective do |f|
  f.description 'Objective description %d'
end

Factory.define :offering_w_objectives, parent: :offering do |f|
  f.objectives { 3.repetitions { Factory :objective } }
end

Factory.define :assessment do |f|
  f.offering { Factory :offering }
end

Factory.define :objective_assessment do |f|
  f.assessment do
    Factory :assessment, offering: Factory(:offering_w_objectives)
  end
  f.objective { |o| o.offering.objectives.first }
end
