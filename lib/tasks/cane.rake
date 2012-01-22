namespace :test do
  desc "Run code quality test"
  Rake::TestTask.new('code-qa') do |t|
    t.loader = :testrb
    t.test_files = ['test/code_qa.rb']
    t.options = %q{--name "/code_quality/"}
  end

  desc "Run code qa and coverage test"
  Rake::TestTask.new('qa-and-coverage') do |t|
    t.test_files = ['test/code_qa.rb']
  end
end

task :test do
  Rake::Task['test:qa-and-coverage'].invoke
end
