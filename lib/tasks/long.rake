namespace :test do
  desc "Run long tests"
  task :long do
    ENV['LONG_TESTS'] = 'yes'
    Rake::Task['test'].invoke
  end
end

