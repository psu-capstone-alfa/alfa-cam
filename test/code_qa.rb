require 'minitest/spec'
require 'minitest/autorun'

# Don't fail if `turn` is not available
begin
  require 'turn'
  Turn.config do |config|
    config.natural = true
  end
rescue LoadError
end


describe 'Code QA' do
  it "must pass code quality standards" do
    app = %q{"app/**/*.rb"}

    command = "cane"
    command << " --abc-glob #{app}"
    command << " --style-glob #{app}"
    command << " --doc-glob #{app}"

    system(command).must_equal true, 'Code does not meet quality standards'
  end
end

describe 'Code Coverage' do
  i_suck_and_my_tests_are_order_dependent!

  before do
    unless File.exists?('coverage/covered_percent')
      flunk('Code coverage has not run')
    end
  end

  it "must have a recent code coverage report" do
    coverage_test_time = File.ctime('coverage/covered_percent')
    coverage_test_time.must_be_within_delta(Time.now,
      60,
      'Coverage test data too old')
  end

  it "must have 90% or greater code coverage" do
    command = "cane"
    command << " --gte 'coverage/covered_percent,90'"
    system(command).must_equal true, 'Insufficient code coverage'
  end
end
