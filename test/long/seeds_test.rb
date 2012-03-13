require "minitest_helper"

if ENV['LONG_TESTS']

  describe 'Database seeds' do
    it "must seed without problem" do
      require File.join(File.dirname(__FILE__), '../..', 'db/seeds')
    end
  end

end
