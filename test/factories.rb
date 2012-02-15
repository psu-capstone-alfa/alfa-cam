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

# Whoo, monkey patchin' !
class Integer
  def repetitions(item=nil, &block)
    range = (1..self).to_a
    if block_given?
      warn "warning: ignoring item argument" unless item.nil?
      range.map! &block
    else
      range.map! { item }
    end
  end
end



Factory.define :course do |f|
  f.dept_code 'CS'
  f.course_num '%d'
  f.title 'A course title'
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

Factory.define :content_group do |f|
  f.offering { Factory :offering }
end
