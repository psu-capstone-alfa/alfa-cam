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

