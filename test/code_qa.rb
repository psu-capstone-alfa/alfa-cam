require 'minitest/spec'
require 'minitest/autorun'

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

  it "must have 70% or greater code coverage" do
    File.open('coverage/covered_percent','r') do |file|
      covered_percent = file.gets
      covered_percent.wont_be_nil 'No coverage percentage'
      Float(covered_percent).round(1).must_be :>, 70,
        'Insufficient code coverage percentage'
    end
  end
end
