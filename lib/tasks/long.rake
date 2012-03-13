namespace :test do
  desc "Run long tests"
  task :long do
    Rake::Task['test'].invoke
    ENV['LONG_TESTS'] = 'yes'
    Rake::Task['test:long:run'].invoke
  end
  namespace :long do
    Rake::TestTask.new(:run) do |t|
      t.libs << 'test'
      t.pattern = 'test/long/*_test.rb'
    end
  end
end

