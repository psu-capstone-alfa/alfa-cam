namespace :test do
  desc "Run code quality test"
  Rake::TestTask.new('code-qa') do |t|
    t.test_files = ['test/code_qa.rb']
  end
end

task :test do
  Rake::Task['test:code-qa'].invoke
end
